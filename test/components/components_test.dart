import 'package:flutter_test/flutter_test.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'header_test.dart' as header;
import 'material_card_test.dart' as material_card;
import 'time_record_card_test.dart' as time_record_card;

main() {
  group('components', () {
    group('loading indicator', () {
      testWidgets('should show a loading component',
          (WidgetTester tester) async {
        await tester.pumpWidget(LoadingIndicator());

        expect(find.byKey(Keys.loading), findsOneWidget);
      });
    });

    header.main();

    material_card.main();

    time_record_card.main();
  });
}
