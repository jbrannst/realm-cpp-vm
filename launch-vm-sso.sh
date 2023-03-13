source config.sh

export AWS_PAGER=""

echo "Logging in using AWS SSO"
aws sso login --profile $SSO_PROFILE


echo "Spinning up AWS instance"
aws ec2 run-instances --profile $SSO_PROFILE --image-id $IMAGE --count 1 --instance-type $INSTTYPE --key-name $KEYNAME \
  --security-group-ids $SECGROUP --subnet-id subnet-0fac31a979864fbdc --block-device-mappings '[{"DeviceName": "/dev/xvda", "Ebs": {"DeleteOnTermination": true, "VolumeSize": 16, "VolumeType": "gp3"}}]' \
  --tag-specification "ResourceType=instance,Tags=[{Key=Name, Value=\"$NAMETAG\"},{Key=owner, Value=\"$OWNERTAG\"}, {Key=expire-on,Value=\"$EXPIRE_ON\"}, {Key=purpose,Value=\"opportunity\"}]" > /dev/null

#sleep 20
sleep 10


res=$(aws ec2 describe-instances --profile $SSO_PROFILE --filters "Name=tag:owner,Values=$OWNERTAG" "Name=tag:Name,Values=$NAMETAG" "Name=instance-state-name,Values=running")
echo $res
PUBDNS=$(echo $res | jq -r '.Reservations[0].Instances[0].PublicDnsName')
PUBIP=$(echo $res | jq -r '.Reservations[0].Instances[0].PublicIpAddress')
ID=$(echo $res | jq -r '.Reservations[0].Instances[0].InstanceId')
echo "Public DNS is $PUBDNS"
until test $PUBDNS != "null"
do
  sleep 1
  printf "."
  res=$(aws ec2 describe-instances --profile $SSO_PROFILE --filters "Name=tag:owner,Values=$OWNERTAG" "Name=tag:Name,Values=$NAMETAG" "Name=instance-state-name,Values=running")
  PUBDNS=$(echo $res | jq -r '.Reservations[0].Instances[0].PublicDnsName')
  PUBIP=$(echo $res | jq -r '.Reservations[0].Instances[0].PublicIpAddress')
done

echo "Public DNS is $PUBDNS; waiting for ssh"

sleep 1
nc -z $PUBDNS 22
until test $? -eq 0
do
  sleep 1
  printf "."
  nc -z $PUBDNS 22
done

echo "APP_ID: $APP_ID"
ssh -i $KEYPATH -oStrictHostKeyChecking=no ec2-user@$PUBDNS <<EOF
cd cpprealm-docker
grep -i 'std::string app_id' cpprealm-example/main.cpp 
sed -i -E 's/(app_id = ")(.*)"/\1'$APP_ID'"/g' cpprealm-example/main.cpp 
docker build -t mongo-cpp-iot -f iot.Dockerfile .
EOF

echo "---------------------------------------------------------------------------------------------------"
echo "We're ready! To start, run:"
echo "docker run mongo-cpp-iot"
echo "---------------------------------------------------------------------------------------------------"
echo "Logging in to VM at"
echo "ssh -i $KEYPATH -oStrictHostKeyChecking=no ec2-user@$PUBDNS"
ssh -i $KEYPATH -oStrictHostKeyChecking=no ec2-user@$PUBDNS
