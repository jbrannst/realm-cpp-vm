source config.sh

aws ec2 create-network-acl-entry --profile $SSO_PROFILE --network-acl-id acl-0a7cf929aad902732 --egress --rule-number 99 --protocol all --port-range From=0,To=65535 --cidr-block 0.0.0.0/0 --rule-action deny