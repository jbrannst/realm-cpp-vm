# C++ Realm SDK Device Sync demo for IoT
Instructions for running with VM

Pre-reqs: 
1. Have an Atlas account and a cluster running, blank M10 is fine
2. Active programmatic key from the AWS console login, or AWS-SSO (recommended)
3. Target eu-west-1 (using .aws/credentials)
4. Update config.sh
5. Launch VM
```
./launch-vm-sso.sh
```
6. Update hardcoded app services APP_ID to yours
```
cd cpprealm-docker
vi cpp-example/main.cpp
```
7. build using docker
```
docker build -t mongo-cpp-iot -f iot.Dockerfile .
```
8. run
```
docker run mongo-cpp-iot
```
9. start consumer.py in a different tab
```
python3 consumer.py
```
10. Watch the messages arrive, then block internet access

