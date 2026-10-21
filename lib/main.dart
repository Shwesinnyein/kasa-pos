import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/database/app_database.dart';
import 'core/database/database_seeder.dart';
import 'core/providers.dart';
import 'features/sync/data/web_save.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase(null, kIsWeb ? WebSaveInterceptor(webSaveHub) : null);
  await DatabaseSeeder(database).seedIfEmpty();
  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)],
      child: const KasaApp(),
    ),
  );
}
