import 'package:flutter_test/flutter_test.dart';
import 'reducers_test.dart' as reducers;
import 'selectors_test.dart' as selectors;

main() {
  group('state', () {
    reducers.main();

    selectors.main();
  });
}
