import 'package:flutter/widgets.dart';
import 'package:tracksite/helpers/helpers.dart';

class LocalNavigator {
  final NavigatorState navigator;
  LocalNavigator(this.navigator);

  toLogin() {
    navigator.pushNamed(Routes.login);
  }

  toHome() {
    navigator.pushNamed(Routes.home);
  }

  pushReplacementTimeRecordDetails() {
    navigator.pushReplacementNamed(Routes.timeRecordDetails);
  }

  pushReplacementMaterialRecordDetails() {
    navigator.pushReplacementNamed(Routes.materialRecordDetails);
  }

  pop() {
    navigator.pop();
  }
}
