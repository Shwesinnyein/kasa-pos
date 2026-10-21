import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/database/database_seeder.dart';
import 'core/database/open_database.dart' if (dart.library.js_interop) 'core/database/open_database_web.dart';
import 'core/providers.dart';
import 'features/sync/data/cloud_sync.dart';
import 'features/sync/data/web_save.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openAppDatabase();
  if (kIsWeb) {
    await CloudSync(database, onDone: () {}, hub: webSaveHub).push();
    final shops = await database.select(database.shops).get();
    if (shops.isEmpty) await DatabaseSeeder(database).seedIfEmpty();
  } else {
    await DatabaseSeeder(database).seedIfEmpty();
  }
  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)],
      child: const KasaApp(),
    ),
  );
}
