import 'package:tracksite/models/models.dart';

export 'report.dart';
export 'time_records.dart';
export 'material_records.dart';
export 'report_count.dart';

class SignInAction {
  final String username;
  final String password;
  final LocalNavigator navigator;

  SignInAction(this.username, this.password, this.navigator);

  @override
  String toString() {
    return 'SignInAction{username: $username, password: $password, navigator: $navigator}';
  }
}

class SetErrorAction {
  final dynamic error;

  SetErrorAction(this.error);

  @override
  String toString() {
    return 'SetErrorAction{error: $error}';
  }
}

class InitAppAction {
  @override
  String toString() {
    return 'InitAppAction{}';
  }
}

class CheckUserAction {
  final LocalNavigator navigator;

  CheckUserAction(this.navigator);

  @override
  String toString() {
    return 'CheckUserAction{navigator: $navigator}';
  }
}

class SetTrackHours {
  final bool trackHours;

  SetTrackHours(this.trackHours);

  @override
  String toString() {
    return 'SetTrackHours{trackHours: $trackHours}';
  }
}

class UpdateLocaleAction {
  final String locale;

  UpdateLocaleAction(this.locale);

  @override
  String toString() {
    return 'UpdateLocaleAction{locale: $locale}';
  }
}
