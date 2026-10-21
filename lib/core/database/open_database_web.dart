import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

import '../../features/sync/data/web_save.dart';
import 'app_database.dart';

Future<AppDatabase> openAppDatabase() async {
  final probed = await WasmDatabase.probe(
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    driftWorkerUri: Uri.parse('drift_worker.js'),
    databaseName: 'kasa-live',
  );
  final connection = await probed.open(WasmStorageImplementation.inMemory, 'kasa-live');
  return AppDatabase(connection.executor.interceptWith(WebSaveInterceptor(webSaveHub)));
}
