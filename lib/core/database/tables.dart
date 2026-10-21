import 'package:drift/drift.dart';

class Shops extends Table {
  TextColumn get id => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameMm => text().nullable()();
  TextColumn get receiptLanguage => text().withDefault(const Constant('my'))();
  TextColumn get currency => text().withDefault(const Constant('MMK'))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Devices extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get name => text()();
  TextColumn get platform => text()();
  TextColumn get language => text().withDefault(const Constant('my'))();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  TextColumn get themeColor => text().withDefault(const Constant('brown'))();
  DateTimeColumn get lastSyncAt => dateTime().nullable()();
  TextColumn get supabaseUrl => text().nullable()();
  TextColumn get supabaseKey => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Staff extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get name => text()();
  TextColumn get role => text()();
  TextColumn get pinHash => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get parentId => text().nullable()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameMm => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get deviceId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Units extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameMm => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Products extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get categoryId => text()();
  TextColumn get unitId => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameMm => text().nullable()();
  TextColumn get barcode => text().nullable()();
  TextColumn get sku => text().nullable()();
  RealColumn get cost => real().withDefault(const Constant(0))();
  RealColumn get price => real()();
  RealColumn get packSize => real().nullable()();
  RealColumn get packPrice => real().nullable()();
  RealColumn get buyPrice => real().nullable()();
  RealColumn get packBuyPrice => real().nullable()();
  RealColumn get previousPrice => real().nullable()();
  RealColumn get previousPackPrice => real().nullable()();
  RealColumn get reorderLevel => real().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get deviceId => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Suppliers extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameMm => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Purchases extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get deviceId => text()();
  TextColumn get supplierId => text().nullable()();
  TextColumn get staffId => text()();
  TextColumn get purchaseNo => text()();
  DateTimeColumn get purchasedAt => dateTime()();
  RealColumn get total => real()();
  TextColumn get note => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PurchaseLines extends Table {
  TextColumn get id => text()();
  TextColumn get purchaseId => text()();
  TextColumn get productId => text()();
  RealColumn get qty => real()();
  RealColumn get unitCost => real()();
  RealColumn get lineTotal => real()();
  RealColumn get packSize => real().withDefault(const Constant(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Sales extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get deviceId => text()();
  TextColumn get staffId => text()();
  TextColumn get saleNo => text()();
  DateTimeColumn get soldAt => dateTime()();
  RealColumn get subtotal => real()();
  RealColumn get discount => real().withDefault(const Constant(0))();
  RealColumn get total => real()();
  RealColumn get paidAmount => real()();
  TextColumn get paymentMethod => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SaleLines extends Table {
  TextColumn get id => text()();
  TextColumn get saleId => text()();
  TextColumn get productId => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameMm => text().nullable()();
  RealColumn get qty => real()();
  RealColumn get unitPrice => real()();
  RealColumn get unitCost => real()();
  RealColumn get lineTotal => real()();
  RealColumn get lineCost => real()();
  RealColumn get packSize => real().withDefault(const Constant(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Damages extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get deviceId => text()();
  TextColumn get staffId => text()();
  TextColumn get damageNo => text()();
  DateTimeColumn get damagedAt => dateTime()();
  TextColumn get note => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DamageLines extends Table {
  TextColumn get id => text()();
  TextColumn get damageId => text()();
  TextColumn get productId => text()();
  RealColumn get qty => real()();
  RealColumn get unitCost => real()();
  RealColumn get lineCost => real()();
  TextColumn get reason => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ExpenseCategories extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameMm => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get deviceId => text()();
  TextColumn get staffId => text()();
  TextColumn get expenseCategoryId => text()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  DateTimeColumn get spentAt => dateTime()();
  TextColumn get note => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Repurchases extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get repurchaseNo => text()();
  TextColumn get status => text().withDefault(const Constant('open'))();
  TextColumn get purchaseId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class RepurchaseItems extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get repurchaseId => text().withDefault(const Constant(''))();
  TextColumn get productId => text()();
  RealColumn get qty => real().withDefault(const Constant(1))();
  RealColumn get packQty => real().withDefault(const Constant(0))();
  RealColumn get packSize => real().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DeveloperReports extends Table {
  TextColumn get id => text()();
  TextColumn get message => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class StockMovements extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get productId => text()();
  TextColumn get sourceType => text()();
  TextColumn get sourceId => text()();
  RealColumn get qtyChange => real()();
  RealColumn get unitCost => real()();
  DateTimeColumn get happenedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
