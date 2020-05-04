#!/usr/bin/env bash
#Place this script in project/android/app/

cd ..

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


# build APK
# force the use of appcenter build number for android. (ios uses it by default)
flutter build apk --release --build-number=$APPCENTER_BUILD_ID

# if you need build bundle (AAB) in addition to your APK, uncomment line below and last line of this script.
flutter build appbundle

# copy the APK where AppCenter will find it
mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/apk/release/app-release.apk $_

# copy the AAB where AppCenter will find it
mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app.aab $_