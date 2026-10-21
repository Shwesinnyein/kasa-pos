import '../../../core/database/app_database.dart';
import '../domain/entities/shop_profile.dart';

class ShopLocalDataSource {
  const ShopLocalDataSource(this._db);

  final AppDatabase _db;

  Future<ShopProfile> load() async {
    final row = await _db.select(_db.shops).getSingle();
    return ShopProfile(id: row.id, nameMm: row.nameMm ?? '', nameEn: row.nameEn ?? '');
  }
}
