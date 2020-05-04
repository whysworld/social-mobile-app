export 'localization.dart';
export 'formatter.dart';
export 'routes.dart';
export 'keys.dart';
export 'jwt.dart';
export 'customerSharedPrefences.dart';

import 'package:package_info/package_info.dart';

bool notNull(Object o) => o != null;

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

String getVersionNumber(PackageInfo packageInfo, String environment) {
      if(isStagingEnv(environment)){
        return packageInfo.version + '_rc';
      }
      return packageInfo.version;
}

bool isStagingEnv(String environment) {
  return environment.contains('staging');
}
