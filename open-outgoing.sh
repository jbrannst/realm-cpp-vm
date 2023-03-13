source config.sh

aws ec2 delete-network-acl-entry --profile $SSO_PROFILE --network-acl-id acl-0a7cf929aad902732 --egress --rule-number 99