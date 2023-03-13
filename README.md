# C++ Realm SDK Device Sync demo for IoT
Instructions for running with VM

Pre-reqs: 
1. Have an Atlas account and a cluster running, blank M10 is fine
2. Active programmatic key from the AWS console login, or AWS-SSO (recommended)
3. Target eu-west-1 (using .aws/credentials) because AMI is stored there
4. Create a default "Device Sync" App Service: In Authenticaction enable "Anonymous" and in Roles set Default Role to "Users can read and write all data". Or, set your Atlas API public/private key in config.sh and run ./sync-setup.sh. If your M10 is not called Cluster0, update the files in realm/sync accordingly before running.
5. Update config.sh
6. Launch VM
```
./launch-vm-sso.sh
```
7. run the C++ SDK with docker
```
docker run mongo-cpp-iot
```
8. start consumer.py in a different tab to watch messages arrive in Atlas. NOTE: if you manually created your app service, it sometimes takes a few minutes for Device Sync to auto-generate schema on the backend, and delay data landing in Atlas.
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

