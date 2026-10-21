import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';
import '../../sync/data/cloud_sync.dart';

class AppSettings {
  const AppSettings({required this.language, required this.themeMode, required this.themeColor});

  final String language;
  final String themeMode;
  final String themeColor;

  static const fallback = AppSettings(language: 'my', themeMode: 'system', themeColor: 'brown');

  bool get english => language == 'en';

  ThemeMode get mode {
    return switch (themeMode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Color get color => themePalette[themeColor] ?? themePalette['brown']!;

  AppSettings copyWith({String? language, String? themeMode, String? themeColor}) {
    return AppSettings(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}

class DeveloperNote {
  const DeveloperNote({required this.message, required this.createdAt});

  final String message;
  final DateTime createdAt;
}

class SettingsLocalDataSource {
  const SettingsLocalDataSource(this._db);

  final AppDatabase _db;

  Future<AppSettings> load() async {
    final device = await (_db.select(_db.devices)..where((row) => row.id.equals(DatabaseSeeder.deviceId))).getSingleOrNull();
    if (device == null) return AppSettings.fallback;
    return AppSettings(language: device.language, themeMode: device.themeMode, themeColor: device.themeColor);
  }

  Future<void> save(AppSettings settings) async {
    await (_db.update(_db.devices)..where((row) => row.id.equals(DatabaseSeeder.deviceId))).write(
      DevicesCompanion(language: Value(settings.language), themeMode: Value(settings.themeMode), themeColor: Value(settings.themeColor)),
    );
  }

  Future<void> renameShop(String name) async {
    await (_db.update(_db.shops)..where((row) => row.id.equals(DatabaseSeeder.shopId))).write(ShopsCompanion(nameMm: Value(name.trim())));
  }

  Future<void> renameStaff(String id, String name) async {
    await (_db.update(_db.staff)..where((row) => row.id.equals(id))).write(StaffCompanion(name: Value(name.trim())));
  }

  Future<List<DeveloperNote>> reports() async {
    final rows = await (_db.select(_db.developerReports)..orderBy([(row) => OrderingTerm.desc(row.createdAt)])).get();
    return [for (final row in rows) DeveloperNote(message: row.message, createdAt: row.createdAt)];
  }

  Future<CloudConfig> loadCloud() async {
    final device = await (_db.select(_db.devices)..where((row) => row.id.equals(DatabaseSeeder.deviceId))).getSingleOrNull();
    if (device == null) return CloudConfig.empty;
    return CloudConfig.saved(url: device.supabaseUrl, key: device.supabaseKey);
  }

  Future<void> saveCloud(CloudConfig config) async {
    await (_db.update(_db.devices)..where((row) => row.id.equals(DatabaseSeeder.deviceId))).write(
      DevicesCompanion(supabaseUrl: Value(config.url.trim()), supabaseKey: Value(config.key.trim())),
    );
  }

  Future<void> addReport(String message) async {
    await _db.into(_db.developerReports).insert(
          DeveloperReportsCompanion.insert(id: const Uuid().v4(), message: message.trim(), createdAt: DateTime.now()),
        );
  }
}
