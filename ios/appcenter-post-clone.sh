#!/usr/bin/env bash
#Place this script in project/ios/

# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

flutter channel stable
flutter version v1.9.1+hotfix.6
flutter doctor

echo "Installed flutter to `pwd`/flutter"

echo "generate config file to ./assets/config/app_config.json"
JSON="{\"apiUrl\": \"$APP_API_URL\",\"policyUrl\": \"$APP_POLICY_URL\", \"environment\": \"$APP_ENVIRONMENT\", \"appCenterSecretIos\": \"$APP_APPCENTERSECRET_IOS\", \"appCenterSecretAndroid\": \"$APP_APPCENTERSECRET_ANDROID\"}"
echo $JSON | tee ./assets/cfg/app_config.json

flutter build ios --release --no-codesign
