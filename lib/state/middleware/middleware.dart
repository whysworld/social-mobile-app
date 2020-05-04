import 'package:redux/redux.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/middleware/app_internal.dart';
import 'package:tracksite/state/middleware/edit_report_flag.dart';
import 'package:tracksite/state/middleware/store_time_records.dart';

List<Middleware<AppState>> createMiddleware(Function(String) updateLocale) => [
      ...appMiddleware(updateLocale),
      ...editReportFlagMiddleware(),
      ...timeRecordsMiddleware(),
    ];
