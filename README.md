# C++ Realm SDK Device Sync demo for IoT
Instructions for running with VM

Pre-reqs: 
1. Have an Atlas account and a cluster running, blank M10 is fine
2. Active programmatic key from the AWS console login, or AWS-SSO (recommended)
3. Target eu-west-1 (using .aws/credentials)
4. Create a default "Device Sync" App Service. Enable "Development Mode" and set Permissions to "Users can read and write all data" 
5. Update config.sh
6. Launch VM
```
./launch-vm-sso.sh
```
7. run the C++ SDK with docker
```
docker run mongo-cpp-iot
```
8. start consumer.py in a different tab to watch messages arrive in Atlas
```
python3 consumer.py
```
8. Block internet access, messages created but not arriving in Atlas
```
./block-outgoing.sh
```
9. Reenable internet access, watch messages pour in
```
./open-outgoing.sh
```

