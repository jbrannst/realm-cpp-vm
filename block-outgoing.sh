source config.sh
INSTID=$(aws ec2 describe-instances --profile $SSO_PROFILE --filters "Name=tag:owner,Values=$OWNERTAG" "Name=tag:Name,Values=$NAMETAG" "Name=instance-state-name,Values=running" | jq -r '.Reservations[0].Instances[0].InstanceId')
aws ec2 modify-instance-attribute --profile $SSO_PROFILE --instance-id $INSTID --groups $SECGROUP_BLOCKED