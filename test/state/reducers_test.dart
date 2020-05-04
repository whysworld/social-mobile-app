import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/state.dart';

main() {
  group('Reducers', () {
    test('should update loading state', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState.init(),
      );

      expect(isLoadingSelector(store.state), true);

      //store.dispatch(LoadTimeRecordsAction(new DateTime.now()));

      expect(isLoadingSelector(store.state), true);

      //store.dispatch(LoadedTimeRecordsAction(new List<TimeRecord>()));

      expect(isLoadingSelector(store.state), false);
    });

    test('should load time records', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState.init(),
      );

      List<TimeRecord> timeRecods = new List<TimeRecord>();
      timeRecods.add(new TimeRecord());

      // expect(timeRecordsSelector(store.state), []);

      //store.dispatch(LoadedTimeRecordsAction(timeRecods));

      // expect(timeRecordsSelector(store.state), timeRecods);
    });
  });
}
