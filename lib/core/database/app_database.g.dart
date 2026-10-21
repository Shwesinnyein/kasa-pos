// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ShopsTable extends Shops with TableInfo<$ShopsTable, Shop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMmMeta = const VerificationMeta('nameMm');
  @override
  late final GeneratedColumn<String> nameMm = GeneratedColumn<String>(
    'name_mm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptLanguageMeta = const VerificationMeta(
    'receiptLanguage',
  );
  @override
  late final GeneratedColumn<String> receiptLanguage = GeneratedColumn<String>(
    'receipt_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('my'),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('MMK'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameMm,
    receiptLanguage,
    currency,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<Shop> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('name_mm')) {
      context.handle(
        _nameMmMeta,
        nameMm.isAcceptableOrUnknown(data['name_mm']!, _nameMmMeta),
      );
    }
    if (data.containsKey('receipt_language')) {
      context.handle(
        _receiptLanguageMeta,
        receiptLanguage.isAcceptableOrUnknown(
          data['receipt_language']!,
          _receiptLanguageMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shop(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      nameMm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_mm'],
      ),
      receiptLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_language'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ShopsTable createAlias(String alias) {
    return $ShopsTable(attachedDatabase, alias);
  }
}

class Shop extends DataClass implements Insertable<Shop> {
  final String id;
  final String? nameEn;
  final String? nameMm;
  final String receiptLanguage;
  final String currency;
  final DateTime createdAt;
  const Shop({
    required this.id,
    this.nameEn,
    this.nameMm,
    required this.receiptLanguage,
    required this.currency,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameMm != null) {
      map['name_mm'] = Variable<String>(nameMm);
    }
    map['receipt_language'] = Variable<String>(receiptLanguage);
    map['currency'] = Variable<String>(currency);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ShopsCompanion toCompanion(bool nullToAbsent) {
    return ShopsCompanion(
      id: Value(id),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      nameMm: nameMm == null && nullToAbsent
          ? const Value.absent()
          : Value(nameMm),
      receiptLanguage: Value(receiptLanguage),
      currency: Value(currency),
      createdAt: Value(createdAt),
    );
  }

  factory Shop.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shop(
      id: serializer.fromJson<String>(json['id']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameMm: serializer.fromJson<String?>(json['nameMm']),
      receiptLanguage: serializer.fromJson<String>(json['receiptLanguage']),
      currency: serializer.fromJson<String>(json['currency']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameMm': serializer.toJson<String?>(nameMm),
      'receiptLanguage': serializer.toJson<String>(receiptLanguage),
      'currency': serializer.toJson<String>(currency),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Shop copyWith({
    String? id,
    Value<String?> nameEn = const Value.absent(),
    Value<String?> nameMm = const Value.absent(),
    String? receiptLanguage,
    String? currency,
    DateTime? createdAt,
  }) => Shop(
    id: id ?? this.id,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    nameMm: nameMm.present ? nameMm.value : this.nameMm,
    receiptLanguage: receiptLanguage ?? this.receiptLanguage,
    currency: currency ?? this.currency,
    createdAt: createdAt ?? this.createdAt,
  );
  Shop copyWithCompanion(ShopsCompanion data) {
    return Shop(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameMm: data.nameMm.present ? data.nameMm.value : this.nameMm,
      receiptLanguage: data.receiptLanguage.present
          ? data.receiptLanguage.value
          : this.receiptLanguage,
      currency: data.currency.present ? data.currency.value : this.currency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shop(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('receiptLanguage: $receiptLanguage, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nameEn, nameMm, receiptLanguage, currency, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shop &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameMm == this.nameMm &&
          other.receiptLanguage == this.receiptLanguage &&
          other.currency == this.currency &&
          other.createdAt == this.createdAt);
}

class ShopsCompanion extends UpdateCompanion<Shop> {
  final Value<String> id;
  final Value<String?> nameEn;
  final Value<String?> nameMm;
  final Value<String> receiptLanguage;
  final Value<String> currency;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ShopsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.receiptLanguage = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopsCompanion.insert({
    required String id,
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.receiptLanguage = const Value.absent(),
    this.currency = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt);
  static Insertable<Shop> custom({
    Expression<String>? id,
    Expression<String>? nameEn,
    Expression<String>? nameMm,
    Expression<String>? receiptLanguage,
    Expression<String>? currency,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameMm != null) 'name_mm': nameMm,
      if (receiptLanguage != null) 'receipt_language': receiptLanguage,
      if (currency != null) 'currency': currency,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopsCompanion copyWith({
    Value<String>? id,
    Value<String?>? nameEn,
    Value<String?>? nameMm,
    Value<String>? receiptLanguage,
    Value<String>? currency,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ShopsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameMm: nameMm ?? this.nameMm,
      receiptLanguage: receiptLanguage ?? this.receiptLanguage,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameMm.present) {
      map['name_mm'] = Variable<String>(nameMm.value);
    }
    if (receiptLanguage.present) {
      map['receipt_language'] = Variable<String>(receiptLanguage.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('receiptLanguage: $receiptLanguage, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DevicesTable extends Devices with TableInfo<$DevicesTable, Device> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('my'),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _themeColorMeta = const VerificationMeta(
    'themeColor',
  );
  @override
  late final GeneratedColumn<String> themeColor = GeneratedColumn<String>(
    'theme_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('brown'),
  );
  static const VerificationMeta _lastSyncAtMeta = const VerificationMeta(
    'lastSyncAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
    'last_sync_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supabaseUrlMeta = const VerificationMeta(
    'supabaseUrl',
  );
  @override
  late final GeneratedColumn<String> supabaseUrl = GeneratedColumn<String>(
    'supabase_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supabaseKeyMeta = const VerificationMeta(
    'supabaseKey',
  );
  @override
  late final GeneratedColumn<String> supabaseKey = GeneratedColumn<String>(
    'supabase_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    name,
    platform,
    language,
    themeMode,
    themeColor,
    lastSyncAt,
    supabaseUrl,
    supabaseKey,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Device> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('theme_color')) {
      context.handle(
        _themeColorMeta,
        themeColor.isAcceptableOrUnknown(data['theme_color']!, _themeColorMeta),
      );
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
        _lastSyncAtMeta,
        lastSyncAt.isAcceptableOrUnknown(
          data['last_sync_at']!,
          _lastSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('supabase_url')) {
      context.handle(
        _supabaseUrlMeta,
        supabaseUrl.isAcceptableOrUnknown(
          data['supabase_url']!,
          _supabaseUrlMeta,
        ),
      );
    }
    if (data.containsKey('supabase_key')) {
      context.handle(
        _supabaseKeyMeta,
        supabaseKey.isAcceptableOrUnknown(
          data['supabase_key']!,
          _supabaseKeyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Device map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Device(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      themeColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_color'],
      )!,
      lastSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_at'],
      ),
      supabaseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supabase_url'],
      ),
      supabaseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supabase_key'],
      ),
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

class Device extends DataClass implements Insertable<Device> {
  final String id;
  final String shopId;
  final String name;
  final String platform;
  final String language;
  final String themeMode;
  final String themeColor;
  final DateTime? lastSyncAt;
  final String? supabaseUrl;
  final String? supabaseKey;
  const Device({
    required this.id,
    required this.shopId,
    required this.name,
    required this.platform,
    required this.language,
    required this.themeMode,
    required this.themeColor,
    this.lastSyncAt,
    this.supabaseUrl,
    this.supabaseKey,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['name'] = Variable<String>(name);
    map['platform'] = Variable<String>(platform);
    map['language'] = Variable<String>(language);
    map['theme_mode'] = Variable<String>(themeMode);
    map['theme_color'] = Variable<String>(themeColor);
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    if (!nullToAbsent || supabaseUrl != null) {
      map['supabase_url'] = Variable<String>(supabaseUrl);
    }
    if (!nullToAbsent || supabaseKey != null) {
      map['supabase_key'] = Variable<String>(supabaseKey);
    }
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      name: Value(name),
      platform: Value(platform),
      language: Value(language),
      themeMode: Value(themeMode),
      themeColor: Value(themeColor),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
      supabaseUrl: supabaseUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(supabaseUrl),
      supabaseKey: supabaseKey == null && nullToAbsent
          ? const Value.absent()
          : Value(supabaseKey),
    );
  }

  factory Device.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Device(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      name: serializer.fromJson<String>(json['name']),
      platform: serializer.fromJson<String>(json['platform']),
      language: serializer.fromJson<String>(json['language']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      themeColor: serializer.fromJson<String>(json['themeColor']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
      supabaseUrl: serializer.fromJson<String?>(json['supabaseUrl']),
      supabaseKey: serializer.fromJson<String?>(json['supabaseKey']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'name': serializer.toJson<String>(name),
      'platform': serializer.toJson<String>(platform),
      'language': serializer.toJson<String>(language),
      'themeMode': serializer.toJson<String>(themeMode),
      'themeColor': serializer.toJson<String>(themeColor),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
      'supabaseUrl': serializer.toJson<String?>(supabaseUrl),
      'supabaseKey': serializer.toJson<String?>(supabaseKey),
    };
  }

  Device copyWith({
    String? id,
    String? shopId,
    String? name,
    String? platform,
    String? language,
    String? themeMode,
    String? themeColor,
    Value<DateTime?> lastSyncAt = const Value.absent(),
    Value<String?> supabaseUrl = const Value.absent(),
    Value<String?> supabaseKey = const Value.absent(),
  }) => Device(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    name: name ?? this.name,
    platform: platform ?? this.platform,
    language: language ?? this.language,
    themeMode: themeMode ?? this.themeMode,
    themeColor: themeColor ?? this.themeColor,
    lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
    supabaseUrl: supabaseUrl.present ? supabaseUrl.value : this.supabaseUrl,
    supabaseKey: supabaseKey.present ? supabaseKey.value : this.supabaseKey,
  );
  Device copyWithCompanion(DevicesCompanion data) {
    return Device(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      name: data.name.present ? data.name.value : this.name,
      platform: data.platform.present ? data.platform.value : this.platform,
      language: data.language.present ? data.language.value : this.language,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      themeColor: data.themeColor.present
          ? data.themeColor.value
          : this.themeColor,
      lastSyncAt: data.lastSyncAt.present
          ? data.lastSyncAt.value
          : this.lastSyncAt,
      supabaseUrl: data.supabaseUrl.present
          ? data.supabaseUrl.value
          : this.supabaseUrl,
      supabaseKey: data.supabaseKey.present
          ? data.supabaseKey.value
          : this.supabaseKey,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Device(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('platform: $platform, ')
          ..write('language: $language, ')
          ..write('themeMode: $themeMode, ')
          ..write('themeColor: $themeColor, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('supabaseUrl: $supabaseUrl, ')
          ..write('supabaseKey: $supabaseKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    name,
    platform,
    language,
    themeMode,
    themeColor,
    lastSyncAt,
    supabaseUrl,
    supabaseKey,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.name == this.name &&
          other.platform == this.platform &&
          other.language == this.language &&
          other.themeMode == this.themeMode &&
          other.themeColor == this.themeColor &&
          other.lastSyncAt == this.lastSyncAt &&
          other.supabaseUrl == this.supabaseUrl &&
          other.supabaseKey == this.supabaseKey);
}

class DevicesCompanion extends UpdateCompanion<Device> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> name;
  final Value<String> platform;
  final Value<String> language;
  final Value<String> themeMode;
  final Value<String> themeColor;
  final Value<DateTime?> lastSyncAt;
  final Value<String?> supabaseUrl;
  final Value<String?> supabaseKey;
  final Value<int> rowid;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.name = const Value.absent(),
    this.platform = const Value.absent(),
    this.language = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.themeColor = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.supabaseUrl = const Value.absent(),
    this.supabaseKey = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesCompanion.insert({
    required String id,
    required String shopId,
    required String name,
    required String platform,
    this.language = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.themeColor = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.supabaseUrl = const Value.absent(),
    this.supabaseKey = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       name = Value(name),
       platform = Value(platform);
  static Insertable<Device> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? name,
    Expression<String>? platform,
    Expression<String>? language,
    Expression<String>? themeMode,
    Expression<String>? themeColor,
    Expression<DateTime>? lastSyncAt,
    Expression<String>? supabaseUrl,
    Expression<String>? supabaseKey,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (name != null) 'name': name,
      if (platform != null) 'platform': platform,
      if (language != null) 'language': language,
      if (themeMode != null) 'theme_mode': themeMode,
      if (themeColor != null) 'theme_color': themeColor,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (supabaseUrl != null) 'supabase_url': supabaseUrl,
      if (supabaseKey != null) 'supabase_key': supabaseKey,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? name,
    Value<String>? platform,
    Value<String>? language,
    Value<String>? themeMode,
    Value<String>? themeColor,
    Value<DateTime?>? lastSyncAt,
    Value<String?>? supabaseUrl,
    Value<String?>? supabaseKey,
    Value<int>? rowid,
  }) {
    return DevicesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      platform: platform ?? this.platform,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      themeColor: themeColor ?? this.themeColor,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      supabaseUrl: supabaseUrl ?? this.supabaseUrl,
      supabaseKey: supabaseKey ?? this.supabaseKey,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (themeColor.present) {
      map['theme_color'] = Variable<String>(themeColor.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (supabaseUrl.present) {
      map['supabase_url'] = Variable<String>(supabaseUrl.value);
    }
    if (supabaseKey.present) {
      map['supabase_key'] = Variable<String>(supabaseKey.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('platform: $platform, ')
          ..write('language: $language, ')
          ..write('themeMode: $themeMode, ')
          ..write('themeColor: $themeColor, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('supabaseUrl: $supabaseUrl, ')
          ..write('supabaseKey: $supabaseKey, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StaffTable extends Staff with TableInfo<$StaffTable, StaffData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    name,
    role,
    pinHash,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff';
  @override
  VerificationContext validateIntegrity(
    Insertable<StaffData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    } else if (isInserting) {
      context.missing(_pinHashMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StaffData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StaffData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $StaffTable createAlias(String alias) {
    return $StaffTable(attachedDatabase, alias);
  }
}

class StaffData extends DataClass implements Insertable<StaffData> {
  final String id;
  final String shopId;
  final String name;
  final String role;
  final String pinHash;
  final bool isActive;
  const StaffData({
    required this.id,
    required this.shopId,
    required this.name,
    required this.role,
    required this.pinHash,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    map['pin_hash'] = Variable<String>(pinHash);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  StaffCompanion toCompanion(bool nullToAbsent) {
    return StaffCompanion(
      id: Value(id),
      shopId: Value(shopId),
      name: Value(name),
      role: Value(role),
      pinHash: Value(pinHash),
      isActive: Value(isActive),
    );
  }

  factory StaffData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StaffData(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      pinHash: serializer.fromJson<String>(json['pinHash']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'pinHash': serializer.toJson<String>(pinHash),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  StaffData copyWith({
    String? id,
    String? shopId,
    String? name,
    String? role,
    String? pinHash,
    bool? isActive,
  }) => StaffData(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    name: name ?? this.name,
    role: role ?? this.role,
    pinHash: pinHash ?? this.pinHash,
    isActive: isActive ?? this.isActive,
  );
  StaffData copyWithCompanion(StaffCompanion data) {
    return StaffData(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StaffData(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('pinHash: $pinHash, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, shopId, name, role, pinHash, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffData &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.name == this.name &&
          other.role == this.role &&
          other.pinHash == this.pinHash &&
          other.isActive == this.isActive);
}

class StaffCompanion extends UpdateCompanion<StaffData> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> name;
  final Value<String> role;
  final Value<String> pinHash;
  final Value<bool> isActive;
  final Value<int> rowid;
  const StaffCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StaffCompanion.insert({
    required String id,
    required String shopId,
    required String name,
    required String role,
    required String pinHash,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       name = Value(name),
       role = Value(role),
       pinHash = Value(pinHash);
  static Insertable<StaffData> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? name,
    Expression<String>? role,
    Expression<String>? pinHash,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (pinHash != null) 'pin_hash': pinHash,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StaffCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? name,
    Value<String>? role,
    Value<String>? pinHash,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return StaffCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      role: role ?? this.role,
      pinHash: pinHash ?? this.pinHash,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('pinHash: $pinHash, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMmMeta = const VerificationMeta('nameMm');
  @override
  late final GeneratedColumn<String> nameMm = GeneratedColumn<String>(
    'name_mm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    parentId,
    nameEn,
    nameMm,
    sortOrder,
    isActive,
    deviceId,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('name_mm')) {
      context.handle(
        _nameMmMeta,
        nameMm.isAcceptableOrUnknown(data['name_mm']!, _nameMmMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      nameMm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_mm'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String shopId;
  final String? parentId;
  final String? nameEn;
  final String? nameMm;
  final int sortOrder;
  final bool isActive;
  final String? deviceId;
  final String syncStatus;
  final DateTime updatedAt;
  const Category({
    required this.id,
    required this.shopId,
    this.parentId,
    this.nameEn,
    this.nameMm,
    required this.sortOrder,
    required this.isActive,
    this.deviceId,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameMm != null) {
      map['name_mm'] = Variable<String>(nameMm);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      nameMm: nameMm == null && nullToAbsent
          ? const Value.absent()
          : Value(nameMm),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameMm: serializer.fromJson<String?>(json['nameMm']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'parentId': serializer.toJson<String?>(parentId),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameMm': serializer.toJson<String?>(nameMm),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'deviceId': serializer.toJson<String?>(deviceId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Category copyWith({
    String? id,
    String? shopId,
    Value<String?> parentId = const Value.absent(),
    Value<String?> nameEn = const Value.absent(),
    Value<String?> nameMm = const Value.absent(),
    int? sortOrder,
    bool? isActive,
    Value<String?> deviceId = const Value.absent(),
    String? syncStatus,
    DateTime? updatedAt,
  }) => Category(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    parentId: parentId.present ? parentId.value : this.parentId,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    nameMm: nameMm.present ? nameMm.value : this.nameMm,
    sortOrder: sortOrder ?? this.sortOrder,
    isActive: isActive ?? this.isActive,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameMm: data.nameMm.present ? data.nameMm.value : this.nameMm,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('parentId: $parentId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('deviceId: $deviceId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    parentId,
    nameEn,
    nameMm,
    sortOrder,
    isActive,
    deviceId,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.parentId == this.parentId &&
          other.nameEn == this.nameEn &&
          other.nameMm == this.nameMm &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.deviceId == this.deviceId &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String?> parentId;
  final Value<String?> nameEn;
  final Value<String?> nameMm;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<String?> deviceId;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String shopId,
    this.parentId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       updatedAt = Value(updatedAt);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? parentId,
    Expression<String>? nameEn,
    Expression<String>? nameMm,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<String>? deviceId,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (parentId != null) 'parent_id': parentId,
      if (nameEn != null) 'name_en': nameEn,
      if (nameMm != null) 'name_mm': nameMm,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (deviceId != null) 'device_id': deviceId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String?>? parentId,
    Value<String?>? nameEn,
    Value<String?>? nameMm,
    Value<int>? sortOrder,
    Value<bool>? isActive,
    Value<String?>? deviceId,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      parentId: parentId ?? this.parentId,
      nameEn: nameEn ?? this.nameEn,
      nameMm: nameMm ?? this.nameMm,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      deviceId: deviceId ?? this.deviceId,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameMm.present) {
      map['name_mm'] = Variable<String>(nameMm.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('parentId: $parentId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('deviceId: $deviceId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UnitsTable extends Units with TableInfo<$UnitsTable, Unit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMmMeta = const VerificationMeta('nameMm');
  @override
  late final GeneratedColumn<String> nameMm = GeneratedColumn<String>(
    'name_mm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    nameEn,
    nameMm,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'units';
  @override
  VerificationContext validateIntegrity(
    Insertable<Unit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('name_mm')) {
      context.handle(
        _nameMmMeta,
        nameMm.isAcceptableOrUnknown(data['name_mm']!, _nameMmMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Unit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Unit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      nameMm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_mm'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UnitsTable createAlias(String alias) {
    return $UnitsTable(attachedDatabase, alias);
  }
}

class Unit extends DataClass implements Insertable<Unit> {
  final String id;
  final String shopId;
  final String? nameEn;
  final String? nameMm;
  final String syncStatus;
  final DateTime updatedAt;
  const Unit({
    required this.id,
    required this.shopId,
    this.nameEn,
    this.nameMm,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameMm != null) {
      map['name_mm'] = Variable<String>(nameMm);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UnitsCompanion toCompanion(bool nullToAbsent) {
    return UnitsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      nameMm: nameMm == null && nullToAbsent
          ? const Value.absent()
          : Value(nameMm),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory Unit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Unit(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameMm: serializer.fromJson<String?>(json['nameMm']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameMm': serializer.toJson<String?>(nameMm),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Unit copyWith({
    String? id,
    String? shopId,
    Value<String?> nameEn = const Value.absent(),
    Value<String?> nameMm = const Value.absent(),
    String? syncStatus,
    DateTime? updatedAt,
  }) => Unit(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    nameMm: nameMm.present ? nameMm.value : this.nameMm,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Unit copyWithCompanion(UnitsCompanion data) {
    return Unit(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameMm: data.nameMm.present ? data.nameMm.value : this.nameMm,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Unit(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, shopId, nameEn, nameMm, syncStatus, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Unit &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.nameEn == this.nameEn &&
          other.nameMm == this.nameMm &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class UnitsCompanion extends UpdateCompanion<Unit> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String?> nameEn;
  final Value<String?> nameMm;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UnitsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UnitsCompanion.insert({
    required String id,
    required String shopId,
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       updatedAt = Value(updatedAt);
  static Insertable<Unit> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? nameEn,
    Expression<String>? nameMm,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (nameEn != null) 'name_en': nameEn,
      if (nameMm != null) 'name_mm': nameMm,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UnitsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String?>? nameEn,
    Value<String?>? nameMm,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UnitsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      nameEn: nameEn ?? this.nameEn,
      nameMm: nameMm ?? this.nameMm,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameMm.present) {
      map['name_mm'] = Variable<String>(nameMm.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMmMeta = const VerificationMeta('nameMm');
  @override
  late final GeneratedColumn<String> nameMm = GeneratedColumn<String>(
    'name_mm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packSizeMeta = const VerificationMeta(
    'packSize',
  );
  @override
  late final GeneratedColumn<double> packSize = GeneratedColumn<double>(
    'pack_size',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _packPriceMeta = const VerificationMeta(
    'packPrice',
  );
  @override
  late final GeneratedColumn<double> packPrice = GeneratedColumn<double>(
    'pack_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buyPriceMeta = const VerificationMeta(
    'buyPrice',
  );
  @override
  late final GeneratedColumn<double> buyPrice = GeneratedColumn<double>(
    'buy_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _packBuyPriceMeta = const VerificationMeta(
    'packBuyPrice',
  );
  @override
  late final GeneratedColumn<double> packBuyPrice = GeneratedColumn<double>(
    'pack_buy_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previousPriceMeta = const VerificationMeta(
    'previousPrice',
  );
  @override
  late final GeneratedColumn<double> previousPrice = GeneratedColumn<double>(
    'previous_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previousPackPriceMeta = const VerificationMeta(
    'previousPackPrice',
  );
  @override
  late final GeneratedColumn<double> previousPackPrice =
      GeneratedColumn<double>(
        'previous_pack_price',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reorderLevelMeta = const VerificationMeta(
    'reorderLevel',
  );
  @override
  late final GeneratedColumn<double> reorderLevel = GeneratedColumn<double>(
    'reorder_level',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    categoryId,
    unitId,
    nameEn,
    nameMm,
    barcode,
    sku,
    cost,
    price,
    packSize,
    packPrice,
    buyPrice,
    packBuyPrice,
    previousPrice,
    previousPackPrice,
    reorderLevel,
    isActive,
    deviceId,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('name_mm')) {
      context.handle(
        _nameMmMeta,
        nameMm.isAcceptableOrUnknown(data['name_mm']!, _nameMmMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('pack_size')) {
      context.handle(
        _packSizeMeta,
        packSize.isAcceptableOrUnknown(data['pack_size']!, _packSizeMeta),
      );
    }
    if (data.containsKey('pack_price')) {
      context.handle(
        _packPriceMeta,
        packPrice.isAcceptableOrUnknown(data['pack_price']!, _packPriceMeta),
      );
    }
    if (data.containsKey('buy_price')) {
      context.handle(
        _buyPriceMeta,
        buyPrice.isAcceptableOrUnknown(data['buy_price']!, _buyPriceMeta),
      );
    }
    if (data.containsKey('pack_buy_price')) {
      context.handle(
        _packBuyPriceMeta,
        packBuyPrice.isAcceptableOrUnknown(
          data['pack_buy_price']!,
          _packBuyPriceMeta,
        ),
      );
    }
    if (data.containsKey('previous_price')) {
      context.handle(
        _previousPriceMeta,
        previousPrice.isAcceptableOrUnknown(
          data['previous_price']!,
          _previousPriceMeta,
        ),
      );
    }
    if (data.containsKey('previous_pack_price')) {
      context.handle(
        _previousPackPriceMeta,
        previousPackPrice.isAcceptableOrUnknown(
          data['previous_pack_price']!,
          _previousPackPriceMeta,
        ),
      );
    }
    if (data.containsKey('reorder_level')) {
      context.handle(
        _reorderLevelMeta,
        reorderLevel.isAcceptableOrUnknown(
          data['reorder_level']!,
          _reorderLevelMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      nameMm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_mm'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      packSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pack_size'],
      ),
      packPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pack_price'],
      ),
      buyPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}buy_price'],
      ),
      packBuyPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pack_buy_price'],
      ),
      previousPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}previous_price'],
      ),
      previousPackPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}previous_pack_price'],
      ),
      reorderLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reorder_level'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String shopId;
  final String categoryId;
  final String unitId;
  final String? nameEn;
  final String? nameMm;
  final String? barcode;
  final String? sku;
  final double cost;
  final double price;
  final double? packSize;
  final double? packPrice;
  final double? buyPrice;
  final double? packBuyPrice;
  final double? previousPrice;
  final double? previousPackPrice;
  final double? reorderLevel;
  final bool isActive;
  final String? deviceId;
  final String syncStatus;
  final DateTime updatedAt;
  const Product({
    required this.id,
    required this.shopId,
    required this.categoryId,
    required this.unitId,
    this.nameEn,
    this.nameMm,
    this.barcode,
    this.sku,
    required this.cost,
    required this.price,
    this.packSize,
    this.packPrice,
    this.buyPrice,
    this.packBuyPrice,
    this.previousPrice,
    this.previousPackPrice,
    this.reorderLevel,
    required this.isActive,
    this.deviceId,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['category_id'] = Variable<String>(categoryId);
    map['unit_id'] = Variable<String>(unitId);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameMm != null) {
      map['name_mm'] = Variable<String>(nameMm);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['cost'] = Variable<double>(cost);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || packSize != null) {
      map['pack_size'] = Variable<double>(packSize);
    }
    if (!nullToAbsent || packPrice != null) {
      map['pack_price'] = Variable<double>(packPrice);
    }
    if (!nullToAbsent || buyPrice != null) {
      map['buy_price'] = Variable<double>(buyPrice);
    }
    if (!nullToAbsent || packBuyPrice != null) {
      map['pack_buy_price'] = Variable<double>(packBuyPrice);
    }
    if (!nullToAbsent || previousPrice != null) {
      map['previous_price'] = Variable<double>(previousPrice);
    }
    if (!nullToAbsent || previousPackPrice != null) {
      map['previous_pack_price'] = Variable<double>(previousPackPrice);
    }
    if (!nullToAbsent || reorderLevel != null) {
      map['reorder_level'] = Variable<double>(reorderLevel);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      categoryId: Value(categoryId),
      unitId: Value(unitId),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      nameMm: nameMm == null && nullToAbsent
          ? const Value.absent()
          : Value(nameMm),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      cost: Value(cost),
      price: Value(price),
      packSize: packSize == null && nullToAbsent
          ? const Value.absent()
          : Value(packSize),
      packPrice: packPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(packPrice),
      buyPrice: buyPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(buyPrice),
      packBuyPrice: packBuyPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(packBuyPrice),
      previousPrice: previousPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(previousPrice),
      previousPackPrice: previousPackPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(previousPackPrice),
      reorderLevel: reorderLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(reorderLevel),
      isActive: Value(isActive),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      unitId: serializer.fromJson<String>(json['unitId']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameMm: serializer.fromJson<String?>(json['nameMm']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      sku: serializer.fromJson<String?>(json['sku']),
      cost: serializer.fromJson<double>(json['cost']),
      price: serializer.fromJson<double>(json['price']),
      packSize: serializer.fromJson<double?>(json['packSize']),
      packPrice: serializer.fromJson<double?>(json['packPrice']),
      buyPrice: serializer.fromJson<double?>(json['buyPrice']),
      packBuyPrice: serializer.fromJson<double?>(json['packBuyPrice']),
      previousPrice: serializer.fromJson<double?>(json['previousPrice']),
      previousPackPrice: serializer.fromJson<double?>(
        json['previousPackPrice'],
      ),
      reorderLevel: serializer.fromJson<double?>(json['reorderLevel']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'categoryId': serializer.toJson<String>(categoryId),
      'unitId': serializer.toJson<String>(unitId),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameMm': serializer.toJson<String?>(nameMm),
      'barcode': serializer.toJson<String?>(barcode),
      'sku': serializer.toJson<String?>(sku),
      'cost': serializer.toJson<double>(cost),
      'price': serializer.toJson<double>(price),
      'packSize': serializer.toJson<double?>(packSize),
      'packPrice': serializer.toJson<double?>(packPrice),
      'buyPrice': serializer.toJson<double?>(buyPrice),
      'packBuyPrice': serializer.toJson<double?>(packBuyPrice),
      'previousPrice': serializer.toJson<double?>(previousPrice),
      'previousPackPrice': serializer.toJson<double?>(previousPackPrice),
      'reorderLevel': serializer.toJson<double?>(reorderLevel),
      'isActive': serializer.toJson<bool>(isActive),
      'deviceId': serializer.toJson<String?>(deviceId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith({
    String? id,
    String? shopId,
    String? categoryId,
    String? unitId,
    Value<String?> nameEn = const Value.absent(),
    Value<String?> nameMm = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    Value<String?> sku = const Value.absent(),
    double? cost,
    double? price,
    Value<double?> packSize = const Value.absent(),
    Value<double?> packPrice = const Value.absent(),
    Value<double?> buyPrice = const Value.absent(),
    Value<double?> packBuyPrice = const Value.absent(),
    Value<double?> previousPrice = const Value.absent(),
    Value<double?> previousPackPrice = const Value.absent(),
    Value<double?> reorderLevel = const Value.absent(),
    bool? isActive,
    Value<String?> deviceId = const Value.absent(),
    String? syncStatus,
    DateTime? updatedAt,
  }) => Product(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    categoryId: categoryId ?? this.categoryId,
    unitId: unitId ?? this.unitId,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    nameMm: nameMm.present ? nameMm.value : this.nameMm,
    barcode: barcode.present ? barcode.value : this.barcode,
    sku: sku.present ? sku.value : this.sku,
    cost: cost ?? this.cost,
    price: price ?? this.price,
    packSize: packSize.present ? packSize.value : this.packSize,
    packPrice: packPrice.present ? packPrice.value : this.packPrice,
    buyPrice: buyPrice.present ? buyPrice.value : this.buyPrice,
    packBuyPrice: packBuyPrice.present ? packBuyPrice.value : this.packBuyPrice,
    previousPrice: previousPrice.present
        ? previousPrice.value
        : this.previousPrice,
    previousPackPrice: previousPackPrice.present
        ? previousPackPrice.value
        : this.previousPackPrice,
    reorderLevel: reorderLevel.present ? reorderLevel.value : this.reorderLevel,
    isActive: isActive ?? this.isActive,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameMm: data.nameMm.present ? data.nameMm.value : this.nameMm,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      sku: data.sku.present ? data.sku.value : this.sku,
      cost: data.cost.present ? data.cost.value : this.cost,
      price: data.price.present ? data.price.value : this.price,
      packSize: data.packSize.present ? data.packSize.value : this.packSize,
      packPrice: data.packPrice.present ? data.packPrice.value : this.packPrice,
      buyPrice: data.buyPrice.present ? data.buyPrice.value : this.buyPrice,
      packBuyPrice: data.packBuyPrice.present
          ? data.packBuyPrice.value
          : this.packBuyPrice,
      previousPrice: data.previousPrice.present
          ? data.previousPrice.value
          : this.previousPrice,
      previousPackPrice: data.previousPackPrice.present
          ? data.previousPackPrice.value
          : this.previousPackPrice,
      reorderLevel: data.reorderLevel.present
          ? data.reorderLevel.value
          : this.reorderLevel,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitId: $unitId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('barcode: $barcode, ')
          ..write('sku: $sku, ')
          ..write('cost: $cost, ')
          ..write('price: $price, ')
          ..write('packSize: $packSize, ')
          ..write('packPrice: $packPrice, ')
          ..write('buyPrice: $buyPrice, ')
          ..write('packBuyPrice: $packBuyPrice, ')
          ..write('previousPrice: $previousPrice, ')
          ..write('previousPackPrice: $previousPackPrice, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('isActive: $isActive, ')
          ..write('deviceId: $deviceId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    shopId,
    categoryId,
    unitId,
    nameEn,
    nameMm,
    barcode,
    sku,
    cost,
    price,
    packSize,
    packPrice,
    buyPrice,
    packBuyPrice,
    previousPrice,
    previousPackPrice,
    reorderLevel,
    isActive,
    deviceId,
    syncStatus,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.categoryId == this.categoryId &&
          other.unitId == this.unitId &&
          other.nameEn == this.nameEn &&
          other.nameMm == this.nameMm &&
          other.barcode == this.barcode &&
          other.sku == this.sku &&
          other.cost == this.cost &&
          other.price == this.price &&
          other.packSize == this.packSize &&
          other.packPrice == this.packPrice &&
          other.buyPrice == this.buyPrice &&
          other.packBuyPrice == this.packBuyPrice &&
          other.previousPrice == this.previousPrice &&
          other.previousPackPrice == this.previousPackPrice &&
          other.reorderLevel == this.reorderLevel &&
          other.isActive == this.isActive &&
          other.deviceId == this.deviceId &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> categoryId;
  final Value<String> unitId;
  final Value<String?> nameEn;
  final Value<String?> nameMm;
  final Value<String?> barcode;
  final Value<String?> sku;
  final Value<double> cost;
  final Value<double> price;
  final Value<double?> packSize;
  final Value<double?> packPrice;
  final Value<double?> buyPrice;
  final Value<double?> packBuyPrice;
  final Value<double?> previousPrice;
  final Value<double?> previousPackPrice;
  final Value<double?> reorderLevel;
  final Value<bool> isActive;
  final Value<String?> deviceId;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.barcode = const Value.absent(),
    this.sku = const Value.absent(),
    this.cost = const Value.absent(),
    this.price = const Value.absent(),
    this.packSize = const Value.absent(),
    this.packPrice = const Value.absent(),
    this.buyPrice = const Value.absent(),
    this.packBuyPrice = const Value.absent(),
    this.previousPrice = const Value.absent(),
    this.previousPackPrice = const Value.absent(),
    this.reorderLevel = const Value.absent(),
    this.isActive = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String shopId,
    required String categoryId,
    required String unitId,
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.barcode = const Value.absent(),
    this.sku = const Value.absent(),
    this.cost = const Value.absent(),
    required double price,
    this.packSize = const Value.absent(),
    this.packPrice = const Value.absent(),
    this.buyPrice = const Value.absent(),
    this.packBuyPrice = const Value.absent(),
    this.previousPrice = const Value.absent(),
    this.previousPackPrice = const Value.absent(),
    this.reorderLevel = const Value.absent(),
    this.isActive = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       categoryId = Value(categoryId),
       unitId = Value(unitId),
       price = Value(price),
       updatedAt = Value(updatedAt);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? categoryId,
    Expression<String>? unitId,
    Expression<String>? nameEn,
    Expression<String>? nameMm,
    Expression<String>? barcode,
    Expression<String>? sku,
    Expression<double>? cost,
    Expression<double>? price,
    Expression<double>? packSize,
    Expression<double>? packPrice,
    Expression<double>? buyPrice,
    Expression<double>? packBuyPrice,
    Expression<double>? previousPrice,
    Expression<double>? previousPackPrice,
    Expression<double>? reorderLevel,
    Expression<bool>? isActive,
    Expression<String>? deviceId,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (categoryId != null) 'category_id': categoryId,
      if (unitId != null) 'unit_id': unitId,
      if (nameEn != null) 'name_en': nameEn,
      if (nameMm != null) 'name_mm': nameMm,
      if (barcode != null) 'barcode': barcode,
      if (sku != null) 'sku': sku,
      if (cost != null) 'cost': cost,
      if (price != null) 'price': price,
      if (packSize != null) 'pack_size': packSize,
      if (packPrice != null) 'pack_price': packPrice,
      if (buyPrice != null) 'buy_price': buyPrice,
      if (packBuyPrice != null) 'pack_buy_price': packBuyPrice,
      if (previousPrice != null) 'previous_price': previousPrice,
      if (previousPackPrice != null) 'previous_pack_price': previousPackPrice,
      if (reorderLevel != null) 'reorder_level': reorderLevel,
      if (isActive != null) 'is_active': isActive,
      if (deviceId != null) 'device_id': deviceId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? categoryId,
    Value<String>? unitId,
    Value<String?>? nameEn,
    Value<String?>? nameMm,
    Value<String?>? barcode,
    Value<String?>? sku,
    Value<double>? cost,
    Value<double>? price,
    Value<double?>? packSize,
    Value<double?>? packPrice,
    Value<double?>? buyPrice,
    Value<double?>? packBuyPrice,
    Value<double?>? previousPrice,
    Value<double?>? previousPackPrice,
    Value<double?>? reorderLevel,
    Value<bool>? isActive,
    Value<String?>? deviceId,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      categoryId: categoryId ?? this.categoryId,
      unitId: unitId ?? this.unitId,
      nameEn: nameEn ?? this.nameEn,
      nameMm: nameMm ?? this.nameMm,
      barcode: barcode ?? this.barcode,
      sku: sku ?? this.sku,
      cost: cost ?? this.cost,
      price: price ?? this.price,
      packSize: packSize ?? this.packSize,
      packPrice: packPrice ?? this.packPrice,
      buyPrice: buyPrice ?? this.buyPrice,
      packBuyPrice: packBuyPrice ?? this.packBuyPrice,
      previousPrice: previousPrice ?? this.previousPrice,
      previousPackPrice: previousPackPrice ?? this.previousPackPrice,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      isActive: isActive ?? this.isActive,
      deviceId: deviceId ?? this.deviceId,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameMm.present) {
      map['name_mm'] = Variable<String>(nameMm.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (packSize.present) {
      map['pack_size'] = Variable<double>(packSize.value);
    }
    if (packPrice.present) {
      map['pack_price'] = Variable<double>(packPrice.value);
    }
    if (buyPrice.present) {
      map['buy_price'] = Variable<double>(buyPrice.value);
    }
    if (packBuyPrice.present) {
      map['pack_buy_price'] = Variable<double>(packBuyPrice.value);
    }
    if (previousPrice.present) {
      map['previous_price'] = Variable<double>(previousPrice.value);
    }
    if (previousPackPrice.present) {
      map['previous_pack_price'] = Variable<double>(previousPackPrice.value);
    }
    if (reorderLevel.present) {
      map['reorder_level'] = Variable<double>(reorderLevel.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitId: $unitId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('barcode: $barcode, ')
          ..write('sku: $sku, ')
          ..write('cost: $cost, ')
          ..write('price: $price, ')
          ..write('packSize: $packSize, ')
          ..write('packPrice: $packPrice, ')
          ..write('buyPrice: $buyPrice, ')
          ..write('packBuyPrice: $packBuyPrice, ')
          ..write('previousPrice: $previousPrice, ')
          ..write('previousPackPrice: $previousPackPrice, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('isActive: $isActive, ')
          ..write('deviceId: $deviceId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMmMeta = const VerificationMeta('nameMm');
  @override
  late final GeneratedColumn<String> nameMm = GeneratedColumn<String>(
    'name_mm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    nameEn,
    nameMm,
    phone,
    note,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('name_mm')) {
      context.handle(
        _nameMmMeta,
        nameMm.isAcceptableOrUnknown(data['name_mm']!, _nameMmMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      nameMm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_mm'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final String id;
  final String shopId;
  final String? nameEn;
  final String? nameMm;
  final String? phone;
  final String? note;
  final String syncStatus;
  final DateTime updatedAt;
  const Supplier({
    required this.id,
    required this.shopId,
    this.nameEn,
    this.nameMm,
    this.phone,
    this.note,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameMm != null) {
      map['name_mm'] = Variable<String>(nameMm);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      shopId: Value(shopId),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      nameMm: nameMm == null && nullToAbsent
          ? const Value.absent()
          : Value(nameMm),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory Supplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameMm: serializer.fromJson<String?>(json['nameMm']),
      phone: serializer.fromJson<String?>(json['phone']),
      note: serializer.fromJson<String?>(json['note']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameMm': serializer.toJson<String?>(nameMm),
      'phone': serializer.toJson<String?>(phone),
      'note': serializer.toJson<String?>(note),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Supplier copyWith({
    String? id,
    String? shopId,
    Value<String?> nameEn = const Value.absent(),
    Value<String?> nameMm = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? syncStatus,
    DateTime? updatedAt,
  }) => Supplier(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    nameMm: nameMm.present ? nameMm.value : this.nameMm,
    phone: phone.present ? phone.value : this.phone,
    note: note.present ? note.value : this.note,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameMm: data.nameMm.present ? data.nameMm.value : this.nameMm,
      phone: data.phone.present ? data.phone.value : this.phone,
      note: data.note.present ? data.note.value : this.note,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('phone: $phone, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    nameEn,
    nameMm,
    phone,
    note,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.nameEn == this.nameEn &&
          other.nameMm == this.nameMm &&
          other.phone == this.phone &&
          other.note == this.note &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String?> nameEn;
  final Value<String?> nameMm;
  final Value<String?> phone;
  final Value<String?> note;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.phone = const Value.absent(),
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersCompanion.insert({
    required String id,
    required String shopId,
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.phone = const Value.absent(),
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       updatedAt = Value(updatedAt);
  static Insertable<Supplier> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? nameEn,
    Expression<String>? nameMm,
    Expression<String>? phone,
    Expression<String>? note,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (nameEn != null) 'name_en': nameEn,
      if (nameMm != null) 'name_mm': nameMm,
      if (phone != null) 'phone': phone,
      if (note != null) 'note': note,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String?>? nameEn,
    Value<String?>? nameMm,
    Value<String?>? phone,
    Value<String?>? note,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      nameEn: nameEn ?? this.nameEn,
      nameMm: nameMm ?? this.nameMm,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameMm.present) {
      map['name_mm'] = Variable<String>(nameMm.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('phone: $phone, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, Purchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseNoMeta = const VerificationMeta(
    'purchaseNo',
  );
  @override
  late final GeneratedColumn<String> purchaseNo = GeneratedColumn<String>(
    'purchase_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasedAtMeta = const VerificationMeta(
    'purchasedAt',
  );
  @override
  late final GeneratedColumn<DateTime> purchasedAt = GeneratedColumn<DateTime>(
    'purchased_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    deviceId,
    supplierId,
    staffId,
    purchaseNo,
    purchasedAt,
    total,
    note,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Purchase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('purchase_no')) {
      context.handle(
        _purchaseNoMeta,
        purchaseNo.isAcceptableOrUnknown(data['purchase_no']!, _purchaseNoMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseNoMeta);
    }
    if (data.containsKey('purchased_at')) {
      context.handle(
        _purchasedAtMeta,
        purchasedAt.isAcceptableOrUnknown(
          data['purchased_at']!,
          _purchasedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasedAtMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Purchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Purchase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      ),
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      purchaseNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_no'],
      )!,
      purchasedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchased_at'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class Purchase extends DataClass implements Insertable<Purchase> {
  final String id;
  final String shopId;
  final String deviceId;
  final String? supplierId;
  final String staffId;
  final String purchaseNo;
  final DateTime purchasedAt;
  final double total;
  final String? note;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Purchase({
    required this.id,
    required this.shopId,
    required this.deviceId,
    this.supplierId,
    required this.staffId,
    required this.purchaseNo,
    required this.purchasedAt,
    required this.total,
    this.note,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['device_id'] = Variable<String>(deviceId);
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<String>(supplierId);
    }
    map['staff_id'] = Variable<String>(staffId);
    map['purchase_no'] = Variable<String>(purchaseNo);
    map['purchased_at'] = Variable<DateTime>(purchasedAt);
    map['total'] = Variable<double>(total);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      deviceId: Value(deviceId),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      staffId: Value(staffId),
      purchaseNo: Value(purchaseNo),
      purchasedAt: Value(purchasedAt),
      total: Value(total),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Purchase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Purchase(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      supplierId: serializer.fromJson<String?>(json['supplierId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      purchaseNo: serializer.fromJson<String>(json['purchaseNo']),
      purchasedAt: serializer.fromJson<DateTime>(json['purchasedAt']),
      total: serializer.fromJson<double>(json['total']),
      note: serializer.fromJson<String?>(json['note']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'deviceId': serializer.toJson<String>(deviceId),
      'supplierId': serializer.toJson<String?>(supplierId),
      'staffId': serializer.toJson<String>(staffId),
      'purchaseNo': serializer.toJson<String>(purchaseNo),
      'purchasedAt': serializer.toJson<DateTime>(purchasedAt),
      'total': serializer.toJson<double>(total),
      'note': serializer.toJson<String?>(note),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Purchase copyWith({
    String? id,
    String? shopId,
    String? deviceId,
    Value<String?> supplierId = const Value.absent(),
    String? staffId,
    String? purchaseNo,
    DateTime? purchasedAt,
    double? total,
    Value<String?> note = const Value.absent(),
    String? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Purchase(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    deviceId: deviceId ?? this.deviceId,
    supplierId: supplierId.present ? supplierId.value : this.supplierId,
    staffId: staffId ?? this.staffId,
    purchaseNo: purchaseNo ?? this.purchaseNo,
    purchasedAt: purchasedAt ?? this.purchasedAt,
    total: total ?? this.total,
    note: note.present ? note.value : this.note,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Purchase copyWithCompanion(PurchasesCompanion data) {
    return Purchase(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      purchaseNo: data.purchaseNo.present
          ? data.purchaseNo.value
          : this.purchaseNo,
      purchasedAt: data.purchasedAt.present
          ? data.purchasedAt.value
          : this.purchasedAt,
      total: data.total.present ? data.total.value : this.total,
      note: data.note.present ? data.note.value : this.note,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Purchase(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('deviceId: $deviceId, ')
          ..write('supplierId: $supplierId, ')
          ..write('staffId: $staffId, ')
          ..write('purchaseNo: $purchaseNo, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('total: $total, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    deviceId,
    supplierId,
    staffId,
    purchaseNo,
    purchasedAt,
    total,
    note,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.deviceId == this.deviceId &&
          other.supplierId == this.supplierId &&
          other.staffId == this.staffId &&
          other.purchaseNo == this.purchaseNo &&
          other.purchasedAt == this.purchasedAt &&
          other.total == this.total &&
          other.note == this.note &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PurchasesCompanion extends UpdateCompanion<Purchase> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> deviceId;
  final Value<String?> supplierId;
  final Value<String> staffId;
  final Value<String> purchaseNo;
  final Value<DateTime> purchasedAt;
  final Value<double> total;
  final Value<String?> note;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.purchaseNo = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.total = const Value.absent(),
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchasesCompanion.insert({
    required String id,
    required String shopId,
    required String deviceId,
    this.supplierId = const Value.absent(),
    required String staffId,
    required String purchaseNo,
    required DateTime purchasedAt,
    required double total,
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       deviceId = Value(deviceId),
       staffId = Value(staffId),
       purchaseNo = Value(purchaseNo),
       purchasedAt = Value(purchasedAt),
       total = Value(total),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Purchase> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? deviceId,
    Expression<String>? supplierId,
    Expression<String>? staffId,
    Expression<String>? purchaseNo,
    Expression<DateTime>? purchasedAt,
    Expression<double>? total,
    Expression<String>? note,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (deviceId != null) 'device_id': deviceId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (staffId != null) 'staff_id': staffId,
      if (purchaseNo != null) 'purchase_no': purchaseNo,
      if (purchasedAt != null) 'purchased_at': purchasedAt,
      if (total != null) 'total': total,
      if (note != null) 'note': note,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchasesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? deviceId,
    Value<String?>? supplierId,
    Value<String>? staffId,
    Value<String>? purchaseNo,
    Value<DateTime>? purchasedAt,
    Value<double>? total,
    Value<String?>? note,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PurchasesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      deviceId: deviceId ?? this.deviceId,
      supplierId: supplierId ?? this.supplierId,
      staffId: staffId ?? this.staffId,
      purchaseNo: purchaseNo ?? this.purchaseNo,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      total: total ?? this.total,
      note: note ?? this.note,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (purchaseNo.present) {
      map['purchase_no'] = Variable<String>(purchaseNo.value);
    }
    if (purchasedAt.present) {
      map['purchased_at'] = Variable<DateTime>(purchasedAt.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('deviceId: $deviceId, ')
          ..write('supplierId: $supplierId, ')
          ..write('staffId: $staffId, ')
          ..write('purchaseNo: $purchaseNo, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('total: $total, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseLinesTable extends PurchaseLines
    with TableInfo<$PurchaseLinesTable, PurchaseLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<String> purchaseId = GeneratedColumn<String>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<double> qty = GeneratedColumn<double>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMeta = const VerificationMeta(
    'unitCost',
  );
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
    'unit_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineTotalMeta = const VerificationMeta(
    'lineTotal',
  );
  @override
  late final GeneratedColumn<double> lineTotal = GeneratedColumn<double>(
    'line_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packSizeMeta = const VerificationMeta(
    'packSize',
  );
  @override
  late final GeneratedColumn<double> packSize = GeneratedColumn<double>(
    'pack_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    productId,
    qty,
    unitCost,
    lineTotal,
    packSize,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('unit_cost')) {
      context.handle(
        _unitCostMeta,
        unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta),
      );
    } else if (isInserting) {
      context.missing(_unitCostMeta);
    }
    if (data.containsKey('line_total')) {
      context.handle(
        _lineTotalMeta,
        lineTotal.isAcceptableOrUnknown(data['line_total']!, _lineTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_lineTotalMeta);
    }
    if (data.containsKey('pack_size')) {
      context.handle(
        _packSizeMeta,
        packSize.isAcceptableOrUnknown(data['pack_size']!, _packSizeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty'],
      )!,
      unitCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost'],
      )!,
      lineTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}line_total'],
      )!,
      packSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pack_size'],
      )!,
    );
  }

  @override
  $PurchaseLinesTable createAlias(String alias) {
    return $PurchaseLinesTable(attachedDatabase, alias);
  }
}

class PurchaseLine extends DataClass implements Insertable<PurchaseLine> {
  final String id;
  final String purchaseId;
  final String productId;
  final double qty;
  final double unitCost;
  final double lineTotal;
  final double packSize;
  const PurchaseLine({
    required this.id,
    required this.purchaseId,
    required this.productId,
    required this.qty,
    required this.unitCost,
    required this.lineTotal,
    required this.packSize,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['purchase_id'] = Variable<String>(purchaseId);
    map['product_id'] = Variable<String>(productId);
    map['qty'] = Variable<double>(qty);
    map['unit_cost'] = Variable<double>(unitCost);
    map['line_total'] = Variable<double>(lineTotal);
    map['pack_size'] = Variable<double>(packSize);
    return map;
  }

  PurchaseLinesCompanion toCompanion(bool nullToAbsent) {
    return PurchaseLinesCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      productId: Value(productId),
      qty: Value(qty),
      unitCost: Value(unitCost),
      lineTotal: Value(lineTotal),
      packSize: Value(packSize),
    );
  }

  factory PurchaseLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseLine(
      id: serializer.fromJson<String>(json['id']),
      purchaseId: serializer.fromJson<String>(json['purchaseId']),
      productId: serializer.fromJson<String>(json['productId']),
      qty: serializer.fromJson<double>(json['qty']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
      lineTotal: serializer.fromJson<double>(json['lineTotal']),
      packSize: serializer.fromJson<double>(json['packSize']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'purchaseId': serializer.toJson<String>(purchaseId),
      'productId': serializer.toJson<String>(productId),
      'qty': serializer.toJson<double>(qty),
      'unitCost': serializer.toJson<double>(unitCost),
      'lineTotal': serializer.toJson<double>(lineTotal),
      'packSize': serializer.toJson<double>(packSize),
    };
  }

  PurchaseLine copyWith({
    String? id,
    String? purchaseId,
    String? productId,
    double? qty,
    double? unitCost,
    double? lineTotal,
    double? packSize,
  }) => PurchaseLine(
    id: id ?? this.id,
    purchaseId: purchaseId ?? this.purchaseId,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
    unitCost: unitCost ?? this.unitCost,
    lineTotal: lineTotal ?? this.lineTotal,
    packSize: packSize ?? this.packSize,
  );
  PurchaseLine copyWithCompanion(PurchaseLinesCompanion data) {
    return PurchaseLine(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
      lineTotal: data.lineTotal.present ? data.lineTotal.value : this.lineTotal,
      packSize: data.packSize.present ? data.packSize.value : this.packSize,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseLine(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitCost: $unitCost, ')
          ..write('lineTotal: $lineTotal, ')
          ..write('packSize: $packSize')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseId,
    productId,
    qty,
    unitCost,
    lineTotal,
    packSize,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseLine &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.productId == this.productId &&
          other.qty == this.qty &&
          other.unitCost == this.unitCost &&
          other.lineTotal == this.lineTotal &&
          other.packSize == this.packSize);
}

class PurchaseLinesCompanion extends UpdateCompanion<PurchaseLine> {
  final Value<String> id;
  final Value<String> purchaseId;
  final Value<String> productId;
  final Value<double> qty;
  final Value<double> unitCost;
  final Value<double> lineTotal;
  final Value<double> packSize;
  final Value<int> rowid;
  const PurchaseLinesCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.lineTotal = const Value.absent(),
    this.packSize = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseLinesCompanion.insert({
    required String id,
    required String purchaseId,
    required String productId,
    required double qty,
    required double unitCost,
    required double lineTotal,
    this.packSize = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       purchaseId = Value(purchaseId),
       productId = Value(productId),
       qty = Value(qty),
       unitCost = Value(unitCost),
       lineTotal = Value(lineTotal);
  static Insertable<PurchaseLine> custom({
    Expression<String>? id,
    Expression<String>? purchaseId,
    Expression<String>? productId,
    Expression<double>? qty,
    Expression<double>? unitCost,
    Expression<double>? lineTotal,
    Expression<double>? packSize,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (unitCost != null) 'unit_cost': unitCost,
      if (lineTotal != null) 'line_total': lineTotal,
      if (packSize != null) 'pack_size': packSize,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseLinesCompanion copyWith({
    Value<String>? id,
    Value<String>? purchaseId,
    Value<String>? productId,
    Value<double>? qty,
    Value<double>? unitCost,
    Value<double>? lineTotal,
    Value<double>? packSize,
    Value<int>? rowid,
  }) {
    return PurchaseLinesCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      unitCost: unitCost ?? this.unitCost,
      lineTotal: lineTotal ?? this.lineTotal,
      packSize: packSize ?? this.packSize,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<String>(purchaseId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<double>(qty.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (lineTotal.present) {
      map['line_total'] = Variable<double>(lineTotal.value);
    }
    if (packSize.present) {
      map['pack_size'] = Variable<double>(packSize.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseLinesCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitCost: $unitCost, ')
          ..write('lineTotal: $lineTotal, ')
          ..write('packSize: $packSize, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleNoMeta = const VerificationMeta('saleNo');
  @override
  late final GeneratedColumn<String> saleNo = GeneratedColumn<String>(
    'sale_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _soldAtMeta = const VerificationMeta('soldAt');
  @override
  late final GeneratedColumn<DateTime> soldAt = GeneratedColumn<DateTime>(
    'sold_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
    'paid_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    deviceId,
    staffId,
    saleNo,
    soldAt,
    subtotal,
    discount,
    total,
    paidAmount,
    paymentMethod,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('sale_no')) {
      context.handle(
        _saleNoMeta,
        saleNo.isAcceptableOrUnknown(data['sale_no']!, _saleNoMeta),
      );
    } else if (isInserting) {
      context.missing(_saleNoMeta);
    }
    if (data.containsKey('sold_at')) {
      context.handle(
        _soldAtMeta,
        soldAt.isAcceptableOrUnknown(data['sold_at']!, _soldAtMeta),
      );
    } else if (isInserting) {
      context.missing(_soldAtMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAmountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      saleNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_no'],
      )!,
      soldAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sold_at'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final String id;
  final String shopId;
  final String deviceId;
  final String staffId;
  final String saleNo;
  final DateTime soldAt;
  final double subtotal;
  final double discount;
  final double total;
  final double paidAmount;
  final String paymentMethod;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Sale({
    required this.id,
    required this.shopId,
    required this.deviceId,
    required this.staffId,
    required this.saleNo,
    required this.soldAt,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.paidAmount,
    required this.paymentMethod,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['device_id'] = Variable<String>(deviceId);
    map['staff_id'] = Variable<String>(staffId);
    map['sale_no'] = Variable<String>(saleNo);
    map['sold_at'] = Variable<DateTime>(soldAt);
    map['subtotal'] = Variable<double>(subtotal);
    map['discount'] = Variable<double>(discount);
    map['total'] = Variable<double>(total);
    map['paid_amount'] = Variable<double>(paidAmount);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      deviceId: Value(deviceId),
      staffId: Value(staffId),
      saleNo: Value(saleNo),
      soldAt: Value(soldAt),
      subtotal: Value(subtotal),
      discount: Value(discount),
      total: Value(total),
      paidAmount: Value(paidAmount),
      paymentMethod: Value(paymentMethod),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      saleNo: serializer.fromJson<String>(json['saleNo']),
      soldAt: serializer.fromJson<DateTime>(json['soldAt']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      discount: serializer.fromJson<double>(json['discount']),
      total: serializer.fromJson<double>(json['total']),
      paidAmount: serializer.fromJson<double>(json['paidAmount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'deviceId': serializer.toJson<String>(deviceId),
      'staffId': serializer.toJson<String>(staffId),
      'saleNo': serializer.toJson<String>(saleNo),
      'soldAt': serializer.toJson<DateTime>(soldAt),
      'subtotal': serializer.toJson<double>(subtotal),
      'discount': serializer.toJson<double>(discount),
      'total': serializer.toJson<double>(total),
      'paidAmount': serializer.toJson<double>(paidAmount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Sale copyWith({
    String? id,
    String? shopId,
    String? deviceId,
    String? staffId,
    String? saleNo,
    DateTime? soldAt,
    double? subtotal,
    double? discount,
    double? total,
    double? paidAmount,
    String? paymentMethod,
    String? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Sale(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    deviceId: deviceId ?? this.deviceId,
    staffId: staffId ?? this.staffId,
    saleNo: saleNo ?? this.saleNo,
    soldAt: soldAt ?? this.soldAt,
    subtotal: subtotal ?? this.subtotal,
    discount: discount ?? this.discount,
    total: total ?? this.total,
    paidAmount: paidAmount ?? this.paidAmount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      saleNo: data.saleNo.present ? data.saleNo.value : this.saleNo,
      soldAt: data.soldAt.present ? data.soldAt.value : this.soldAt,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discount: data.discount.present ? data.discount.value : this.discount,
      total: data.total.present ? data.total.value : this.total,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('deviceId: $deviceId, ')
          ..write('staffId: $staffId, ')
          ..write('saleNo: $saleNo, ')
          ..write('soldAt: $soldAt, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('total: $total, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    deviceId,
    staffId,
    saleNo,
    soldAt,
    subtotal,
    discount,
    total,
    paidAmount,
    paymentMethod,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.deviceId == this.deviceId &&
          other.staffId == this.staffId &&
          other.saleNo == this.saleNo &&
          other.soldAt == this.soldAt &&
          other.subtotal == this.subtotal &&
          other.discount == this.discount &&
          other.total == this.total &&
          other.paidAmount == this.paidAmount &&
          other.paymentMethod == this.paymentMethod &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> deviceId;
  final Value<String> staffId;
  final Value<String> saleNo;
  final Value<DateTime> soldAt;
  final Value<double> subtotal;
  final Value<double> discount;
  final Value<double> total;
  final Value<double> paidAmount;
  final Value<String> paymentMethod;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.saleNo = const Value.absent(),
    this.soldAt = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.total = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesCompanion.insert({
    required String id,
    required String shopId,
    required String deviceId,
    required String staffId,
    required String saleNo,
    required DateTime soldAt,
    required double subtotal,
    this.discount = const Value.absent(),
    required double total,
    required double paidAmount,
    required String paymentMethod,
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       deviceId = Value(deviceId),
       staffId = Value(staffId),
       saleNo = Value(saleNo),
       soldAt = Value(soldAt),
       subtotal = Value(subtotal),
       total = Value(total),
       paidAmount = Value(paidAmount),
       paymentMethod = Value(paymentMethod),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Sale> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? deviceId,
    Expression<String>? staffId,
    Expression<String>? saleNo,
    Expression<DateTime>? soldAt,
    Expression<double>? subtotal,
    Expression<double>? discount,
    Expression<double>? total,
    Expression<double>? paidAmount,
    Expression<String>? paymentMethod,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (deviceId != null) 'device_id': deviceId,
      if (staffId != null) 'staff_id': staffId,
      if (saleNo != null) 'sale_no': saleNo,
      if (soldAt != null) 'sold_at': soldAt,
      if (subtotal != null) 'subtotal': subtotal,
      if (discount != null) 'discount': discount,
      if (total != null) 'total': total,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? deviceId,
    Value<String>? staffId,
    Value<String>? saleNo,
    Value<DateTime>? soldAt,
    Value<double>? subtotal,
    Value<double>? discount,
    Value<double>? total,
    Value<double>? paidAmount,
    Value<String>? paymentMethod,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      deviceId: deviceId ?? this.deviceId,
      staffId: staffId ?? this.staffId,
      saleNo: saleNo ?? this.saleNo,
      soldAt: soldAt ?? this.soldAt,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      paidAmount: paidAmount ?? this.paidAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (saleNo.present) {
      map['sale_no'] = Variable<String>(saleNo.value);
    }
    if (soldAt.present) {
      map['sold_at'] = Variable<DateTime>(soldAt.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('deviceId: $deviceId, ')
          ..write('staffId: $staffId, ')
          ..write('saleNo: $saleNo, ')
          ..write('soldAt: $soldAt, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('total: $total, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SaleLinesTable extends SaleLines
    with TableInfo<$SaleLinesTable, SaleLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMmMeta = const VerificationMeta('nameMm');
  @override
  late final GeneratedColumn<String> nameMm = GeneratedColumn<String>(
    'name_mm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<double> qty = GeneratedColumn<double>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMeta = const VerificationMeta(
    'unitCost',
  );
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
    'unit_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineTotalMeta = const VerificationMeta(
    'lineTotal',
  );
  @override
  late final GeneratedColumn<double> lineTotal = GeneratedColumn<double>(
    'line_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineCostMeta = const VerificationMeta(
    'lineCost',
  );
  @override
  late final GeneratedColumn<double> lineCost = GeneratedColumn<double>(
    'line_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packSizeMeta = const VerificationMeta(
    'packSize',
  );
  @override
  late final GeneratedColumn<double> packSize = GeneratedColumn<double>(
    'pack_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    productId,
    nameEn,
    nameMm,
    qty,
    unitPrice,
    unitCost,
    lineTotal,
    lineCost,
    packSize,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('name_mm')) {
      context.handle(
        _nameMmMeta,
        nameMm.isAcceptableOrUnknown(data['name_mm']!, _nameMmMeta),
      );
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('unit_cost')) {
      context.handle(
        _unitCostMeta,
        unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta),
      );
    } else if (isInserting) {
      context.missing(_unitCostMeta);
    }
    if (data.containsKey('line_total')) {
      context.handle(
        _lineTotalMeta,
        lineTotal.isAcceptableOrUnknown(data['line_total']!, _lineTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_lineTotalMeta);
    }
    if (data.containsKey('line_cost')) {
      context.handle(
        _lineCostMeta,
        lineCost.isAcceptableOrUnknown(data['line_cost']!, _lineCostMeta),
      );
    } else if (isInserting) {
      context.missing(_lineCostMeta);
    }
    if (data.containsKey('pack_size')) {
      context.handle(
        _packSizeMeta,
        packSize.isAcceptableOrUnknown(data['pack_size']!, _packSizeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      nameMm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_mm'],
      ),
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      unitCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost'],
      )!,
      lineTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}line_total'],
      )!,
      lineCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}line_cost'],
      )!,
      packSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pack_size'],
      )!,
    );
  }

  @override
  $SaleLinesTable createAlias(String alias) {
    return $SaleLinesTable(attachedDatabase, alias);
  }
}

class SaleLine extends DataClass implements Insertable<SaleLine> {
  final String id;
  final String saleId;
  final String productId;
  final String? nameEn;
  final String? nameMm;
  final double qty;
  final double unitPrice;
  final double unitCost;
  final double lineTotal;
  final double lineCost;
  final double packSize;
  const SaleLine({
    required this.id,
    required this.saleId,
    required this.productId,
    this.nameEn,
    this.nameMm,
    required this.qty,
    required this.unitPrice,
    required this.unitCost,
    required this.lineTotal,
    required this.lineCost,
    required this.packSize,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sale_id'] = Variable<String>(saleId);
    map['product_id'] = Variable<String>(productId);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameMm != null) {
      map['name_mm'] = Variable<String>(nameMm);
    }
    map['qty'] = Variable<double>(qty);
    map['unit_price'] = Variable<double>(unitPrice);
    map['unit_cost'] = Variable<double>(unitCost);
    map['line_total'] = Variable<double>(lineTotal);
    map['line_cost'] = Variable<double>(lineCost);
    map['pack_size'] = Variable<double>(packSize);
    return map;
  }

  SaleLinesCompanion toCompanion(bool nullToAbsent) {
    return SaleLinesCompanion(
      id: Value(id),
      saleId: Value(saleId),
      productId: Value(productId),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      nameMm: nameMm == null && nullToAbsent
          ? const Value.absent()
          : Value(nameMm),
      qty: Value(qty),
      unitPrice: Value(unitPrice),
      unitCost: Value(unitCost),
      lineTotal: Value(lineTotal),
      lineCost: Value(lineCost),
      packSize: Value(packSize),
    );
  }

  factory SaleLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleLine(
      id: serializer.fromJson<String>(json['id']),
      saleId: serializer.fromJson<String>(json['saleId']),
      productId: serializer.fromJson<String>(json['productId']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameMm: serializer.fromJson<String?>(json['nameMm']),
      qty: serializer.fromJson<double>(json['qty']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
      lineTotal: serializer.fromJson<double>(json['lineTotal']),
      lineCost: serializer.fromJson<double>(json['lineCost']),
      packSize: serializer.fromJson<double>(json['packSize']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'saleId': serializer.toJson<String>(saleId),
      'productId': serializer.toJson<String>(productId),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameMm': serializer.toJson<String?>(nameMm),
      'qty': serializer.toJson<double>(qty),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'unitCost': serializer.toJson<double>(unitCost),
      'lineTotal': serializer.toJson<double>(lineTotal),
      'lineCost': serializer.toJson<double>(lineCost),
      'packSize': serializer.toJson<double>(packSize),
    };
  }

  SaleLine copyWith({
    String? id,
    String? saleId,
    String? productId,
    Value<String?> nameEn = const Value.absent(),
    Value<String?> nameMm = const Value.absent(),
    double? qty,
    double? unitPrice,
    double? unitCost,
    double? lineTotal,
    double? lineCost,
    double? packSize,
  }) => SaleLine(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    productId: productId ?? this.productId,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    nameMm: nameMm.present ? nameMm.value : this.nameMm,
    qty: qty ?? this.qty,
    unitPrice: unitPrice ?? this.unitPrice,
    unitCost: unitCost ?? this.unitCost,
    lineTotal: lineTotal ?? this.lineTotal,
    lineCost: lineCost ?? this.lineCost,
    packSize: packSize ?? this.packSize,
  );
  SaleLine copyWithCompanion(SaleLinesCompanion data) {
    return SaleLine(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      productId: data.productId.present ? data.productId.value : this.productId,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameMm: data.nameMm.present ? data.nameMm.value : this.nameMm,
      qty: data.qty.present ? data.qty.value : this.qty,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
      lineTotal: data.lineTotal.present ? data.lineTotal.value : this.lineTotal,
      lineCost: data.lineCost.present ? data.lineCost.value : this.lineCost,
      packSize: data.packSize.present ? data.packSize.value : this.packSize,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleLine(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('qty: $qty, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('unitCost: $unitCost, ')
          ..write('lineTotal: $lineTotal, ')
          ..write('lineCost: $lineCost, ')
          ..write('packSize: $packSize')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    saleId,
    productId,
    nameEn,
    nameMm,
    qty,
    unitPrice,
    unitCost,
    lineTotal,
    lineCost,
    packSize,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleLine &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.productId == this.productId &&
          other.nameEn == this.nameEn &&
          other.nameMm == this.nameMm &&
          other.qty == this.qty &&
          other.unitPrice == this.unitPrice &&
          other.unitCost == this.unitCost &&
          other.lineTotal == this.lineTotal &&
          other.lineCost == this.lineCost &&
          other.packSize == this.packSize);
}

class SaleLinesCompanion extends UpdateCompanion<SaleLine> {
  final Value<String> id;
  final Value<String> saleId;
  final Value<String> productId;
  final Value<String?> nameEn;
  final Value<String?> nameMm;
  final Value<double> qty;
  final Value<double> unitPrice;
  final Value<double> unitCost;
  final Value<double> lineTotal;
  final Value<double> lineCost;
  final Value<double> packSize;
  final Value<int> rowid;
  const SaleLinesCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.productId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.qty = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.lineTotal = const Value.absent(),
    this.lineCost = const Value.absent(),
    this.packSize = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SaleLinesCompanion.insert({
    required String id,
    required String saleId,
    required String productId,
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    required double qty,
    required double unitPrice,
    required double unitCost,
    required double lineTotal,
    required double lineCost,
    this.packSize = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       saleId = Value(saleId),
       productId = Value(productId),
       qty = Value(qty),
       unitPrice = Value(unitPrice),
       unitCost = Value(unitCost),
       lineTotal = Value(lineTotal),
       lineCost = Value(lineCost);
  static Insertable<SaleLine> custom({
    Expression<String>? id,
    Expression<String>? saleId,
    Expression<String>? productId,
    Expression<String>? nameEn,
    Expression<String>? nameMm,
    Expression<double>? qty,
    Expression<double>? unitPrice,
    Expression<double>? unitCost,
    Expression<double>? lineTotal,
    Expression<double>? lineCost,
    Expression<double>? packSize,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (productId != null) 'product_id': productId,
      if (nameEn != null) 'name_en': nameEn,
      if (nameMm != null) 'name_mm': nameMm,
      if (qty != null) 'qty': qty,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (unitCost != null) 'unit_cost': unitCost,
      if (lineTotal != null) 'line_total': lineTotal,
      if (lineCost != null) 'line_cost': lineCost,
      if (packSize != null) 'pack_size': packSize,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SaleLinesCompanion copyWith({
    Value<String>? id,
    Value<String>? saleId,
    Value<String>? productId,
    Value<String?>? nameEn,
    Value<String?>? nameMm,
    Value<double>? qty,
    Value<double>? unitPrice,
    Value<double>? unitCost,
    Value<double>? lineTotal,
    Value<double>? lineCost,
    Value<double>? packSize,
    Value<int>? rowid,
  }) {
    return SaleLinesCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      nameEn: nameEn ?? this.nameEn,
      nameMm: nameMm ?? this.nameMm,
      qty: qty ?? this.qty,
      unitPrice: unitPrice ?? this.unitPrice,
      unitCost: unitCost ?? this.unitCost,
      lineTotal: lineTotal ?? this.lineTotal,
      lineCost: lineCost ?? this.lineCost,
      packSize: packSize ?? this.packSize,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameMm.present) {
      map['name_mm'] = Variable<String>(nameMm.value);
    }
    if (qty.present) {
      map['qty'] = Variable<double>(qty.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (lineTotal.present) {
      map['line_total'] = Variable<double>(lineTotal.value);
    }
    if (lineCost.present) {
      map['line_cost'] = Variable<double>(lineCost.value);
    }
    if (packSize.present) {
      map['pack_size'] = Variable<double>(packSize.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleLinesCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('qty: $qty, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('unitCost: $unitCost, ')
          ..write('lineTotal: $lineTotal, ')
          ..write('lineCost: $lineCost, ')
          ..write('packSize: $packSize, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DamagesTable extends Damages with TableInfo<$DamagesTable, Damage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DamagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damageNoMeta = const VerificationMeta(
    'damageNo',
  );
  @override
  late final GeneratedColumn<String> damageNo = GeneratedColumn<String>(
    'damage_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damagedAtMeta = const VerificationMeta(
    'damagedAt',
  );
  @override
  late final GeneratedColumn<DateTime> damagedAt = GeneratedColumn<DateTime>(
    'damaged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    deviceId,
    staffId,
    damageNo,
    damagedAt,
    note,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'damages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Damage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('damage_no')) {
      context.handle(
        _damageNoMeta,
        damageNo.isAcceptableOrUnknown(data['damage_no']!, _damageNoMeta),
      );
    } else if (isInserting) {
      context.missing(_damageNoMeta);
    }
    if (data.containsKey('damaged_at')) {
      context.handle(
        _damagedAtMeta,
        damagedAt.isAcceptableOrUnknown(data['damaged_at']!, _damagedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_damagedAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Damage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Damage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      damageNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_no'],
      )!,
      damagedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}damaged_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DamagesTable createAlias(String alias) {
    return $DamagesTable(attachedDatabase, alias);
  }
}

class Damage extends DataClass implements Insertable<Damage> {
  final String id;
  final String shopId;
  final String deviceId;
  final String staffId;
  final String damageNo;
  final DateTime damagedAt;
  final String? note;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Damage({
    required this.id,
    required this.shopId,
    required this.deviceId,
    required this.staffId,
    required this.damageNo,
    required this.damagedAt,
    this.note,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['device_id'] = Variable<String>(deviceId);
    map['staff_id'] = Variable<String>(staffId);
    map['damage_no'] = Variable<String>(damageNo);
    map['damaged_at'] = Variable<DateTime>(damagedAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DamagesCompanion toCompanion(bool nullToAbsent) {
    return DamagesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      deviceId: Value(deviceId),
      staffId: Value(staffId),
      damageNo: Value(damageNo),
      damagedAt: Value(damagedAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Damage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Damage(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      damageNo: serializer.fromJson<String>(json['damageNo']),
      damagedAt: serializer.fromJson<DateTime>(json['damagedAt']),
      note: serializer.fromJson<String?>(json['note']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'deviceId': serializer.toJson<String>(deviceId),
      'staffId': serializer.toJson<String>(staffId),
      'damageNo': serializer.toJson<String>(damageNo),
      'damagedAt': serializer.toJson<DateTime>(damagedAt),
      'note': serializer.toJson<String?>(note),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Damage copyWith({
    String? id,
    String? shopId,
    String? deviceId,
    String? staffId,
    String? damageNo,
    DateTime? damagedAt,
    Value<String?> note = const Value.absent(),
    String? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Damage(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    deviceId: deviceId ?? this.deviceId,
    staffId: staffId ?? this.staffId,
    damageNo: damageNo ?? this.damageNo,
    damagedAt: damagedAt ?? this.damagedAt,
    note: note.present ? note.value : this.note,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Damage copyWithCompanion(DamagesCompanion data) {
    return Damage(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      damageNo: data.damageNo.present ? data.damageNo.value : this.damageNo,
      damagedAt: data.damagedAt.present ? data.damagedAt.value : this.damagedAt,
      note: data.note.present ? data.note.value : this.note,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Damage(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('deviceId: $deviceId, ')
          ..write('staffId: $staffId, ')
          ..write('damageNo: $damageNo, ')
          ..write('damagedAt: $damagedAt, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    deviceId,
    staffId,
    damageNo,
    damagedAt,
    note,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Damage &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.deviceId == this.deviceId &&
          other.staffId == this.staffId &&
          other.damageNo == this.damageNo &&
          other.damagedAt == this.damagedAt &&
          other.note == this.note &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DamagesCompanion extends UpdateCompanion<Damage> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> deviceId;
  final Value<String> staffId;
  final Value<String> damageNo;
  final Value<DateTime> damagedAt;
  final Value<String?> note;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DamagesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.damageNo = const Value.absent(),
    this.damagedAt = const Value.absent(),
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DamagesCompanion.insert({
    required String id,
    required String shopId,
    required String deviceId,
    required String staffId,
    required String damageNo,
    required DateTime damagedAt,
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       deviceId = Value(deviceId),
       staffId = Value(staffId),
       damageNo = Value(damageNo),
       damagedAt = Value(damagedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Damage> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? deviceId,
    Expression<String>? staffId,
    Expression<String>? damageNo,
    Expression<DateTime>? damagedAt,
    Expression<String>? note,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (deviceId != null) 'device_id': deviceId,
      if (staffId != null) 'staff_id': staffId,
      if (damageNo != null) 'damage_no': damageNo,
      if (damagedAt != null) 'damaged_at': damagedAt,
      if (note != null) 'note': note,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DamagesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? deviceId,
    Value<String>? staffId,
    Value<String>? damageNo,
    Value<DateTime>? damagedAt,
    Value<String?>? note,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DamagesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      deviceId: deviceId ?? this.deviceId,
      staffId: staffId ?? this.staffId,
      damageNo: damageNo ?? this.damageNo,
      damagedAt: damagedAt ?? this.damagedAt,
      note: note ?? this.note,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (damageNo.present) {
      map['damage_no'] = Variable<String>(damageNo.value);
    }
    if (damagedAt.present) {
      map['damaged_at'] = Variable<DateTime>(damagedAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DamagesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('deviceId: $deviceId, ')
          ..write('staffId: $staffId, ')
          ..write('damageNo: $damageNo, ')
          ..write('damagedAt: $damagedAt, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DamageLinesTable extends DamageLines
    with TableInfo<$DamageLinesTable, DamageLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DamageLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damageIdMeta = const VerificationMeta(
    'damageId',
  );
  @override
  late final GeneratedColumn<String> damageId = GeneratedColumn<String>(
    'damage_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<double> qty = GeneratedColumn<double>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMeta = const VerificationMeta(
    'unitCost',
  );
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
    'unit_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineCostMeta = const VerificationMeta(
    'lineCost',
  );
  @override
  late final GeneratedColumn<double> lineCost = GeneratedColumn<double>(
    'line_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    damageId,
    productId,
    qty,
    unitCost,
    lineCost,
    reason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'damage_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<DamageLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('damage_id')) {
      context.handle(
        _damageIdMeta,
        damageId.isAcceptableOrUnknown(data['damage_id']!, _damageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_damageIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('unit_cost')) {
      context.handle(
        _unitCostMeta,
        unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta),
      );
    } else if (isInserting) {
      context.missing(_unitCostMeta);
    }
    if (data.containsKey('line_cost')) {
      context.handle(
        _lineCostMeta,
        lineCost.isAcceptableOrUnknown(data['line_cost']!, _lineCostMeta),
      );
    } else if (isInserting) {
      context.missing(_lineCostMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DamageLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DamageLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      damageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty'],
      )!,
      unitCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost'],
      )!,
      lineCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}line_cost'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
    );
  }

  @override
  $DamageLinesTable createAlias(String alias) {
    return $DamageLinesTable(attachedDatabase, alias);
  }
}

class DamageLine extends DataClass implements Insertable<DamageLine> {
  final String id;
  final String damageId;
  final String productId;
  final double qty;
  final double unitCost;
  final double lineCost;
  final String reason;
  const DamageLine({
    required this.id,
    required this.damageId,
    required this.productId,
    required this.qty,
    required this.unitCost,
    required this.lineCost,
    required this.reason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['damage_id'] = Variable<String>(damageId);
    map['product_id'] = Variable<String>(productId);
    map['qty'] = Variable<double>(qty);
    map['unit_cost'] = Variable<double>(unitCost);
    map['line_cost'] = Variable<double>(lineCost);
    map['reason'] = Variable<String>(reason);
    return map;
  }

  DamageLinesCompanion toCompanion(bool nullToAbsent) {
    return DamageLinesCompanion(
      id: Value(id),
      damageId: Value(damageId),
      productId: Value(productId),
      qty: Value(qty),
      unitCost: Value(unitCost),
      lineCost: Value(lineCost),
      reason: Value(reason),
    );
  }

  factory DamageLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DamageLine(
      id: serializer.fromJson<String>(json['id']),
      damageId: serializer.fromJson<String>(json['damageId']),
      productId: serializer.fromJson<String>(json['productId']),
      qty: serializer.fromJson<double>(json['qty']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
      lineCost: serializer.fromJson<double>(json['lineCost']),
      reason: serializer.fromJson<String>(json['reason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'damageId': serializer.toJson<String>(damageId),
      'productId': serializer.toJson<String>(productId),
      'qty': serializer.toJson<double>(qty),
      'unitCost': serializer.toJson<double>(unitCost),
      'lineCost': serializer.toJson<double>(lineCost),
      'reason': serializer.toJson<String>(reason),
    };
  }

  DamageLine copyWith({
    String? id,
    String? damageId,
    String? productId,
    double? qty,
    double? unitCost,
    double? lineCost,
    String? reason,
  }) => DamageLine(
    id: id ?? this.id,
    damageId: damageId ?? this.damageId,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
    unitCost: unitCost ?? this.unitCost,
    lineCost: lineCost ?? this.lineCost,
    reason: reason ?? this.reason,
  );
  DamageLine copyWithCompanion(DamageLinesCompanion data) {
    return DamageLine(
      id: data.id.present ? data.id.value : this.id,
      damageId: data.damageId.present ? data.damageId.value : this.damageId,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
      lineCost: data.lineCost.present ? data.lineCost.value : this.lineCost,
      reason: data.reason.present ? data.reason.value : this.reason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DamageLine(')
          ..write('id: $id, ')
          ..write('damageId: $damageId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitCost: $unitCost, ')
          ..write('lineCost: $lineCost, ')
          ..write('reason: $reason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, damageId, productId, qty, unitCost, lineCost, reason);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DamageLine &&
          other.id == this.id &&
          other.damageId == this.damageId &&
          other.productId == this.productId &&
          other.qty == this.qty &&
          other.unitCost == this.unitCost &&
          other.lineCost == this.lineCost &&
          other.reason == this.reason);
}

class DamageLinesCompanion extends UpdateCompanion<DamageLine> {
  final Value<String> id;
  final Value<String> damageId;
  final Value<String> productId;
  final Value<double> qty;
  final Value<double> unitCost;
  final Value<double> lineCost;
  final Value<String> reason;
  final Value<int> rowid;
  const DamageLinesCompanion({
    this.id = const Value.absent(),
    this.damageId = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.lineCost = const Value.absent(),
    this.reason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DamageLinesCompanion.insert({
    required String id,
    required String damageId,
    required String productId,
    required double qty,
    required double unitCost,
    required double lineCost,
    required String reason,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       damageId = Value(damageId),
       productId = Value(productId),
       qty = Value(qty),
       unitCost = Value(unitCost),
       lineCost = Value(lineCost),
       reason = Value(reason);
  static Insertable<DamageLine> custom({
    Expression<String>? id,
    Expression<String>? damageId,
    Expression<String>? productId,
    Expression<double>? qty,
    Expression<double>? unitCost,
    Expression<double>? lineCost,
    Expression<String>? reason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (damageId != null) 'damage_id': damageId,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (unitCost != null) 'unit_cost': unitCost,
      if (lineCost != null) 'line_cost': lineCost,
      if (reason != null) 'reason': reason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DamageLinesCompanion copyWith({
    Value<String>? id,
    Value<String>? damageId,
    Value<String>? productId,
    Value<double>? qty,
    Value<double>? unitCost,
    Value<double>? lineCost,
    Value<String>? reason,
    Value<int>? rowid,
  }) {
    return DamageLinesCompanion(
      id: id ?? this.id,
      damageId: damageId ?? this.damageId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      unitCost: unitCost ?? this.unitCost,
      lineCost: lineCost ?? this.lineCost,
      reason: reason ?? this.reason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (damageId.present) {
      map['damage_id'] = Variable<String>(damageId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<double>(qty.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (lineCost.present) {
      map['line_cost'] = Variable<double>(lineCost.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DamageLinesCompanion(')
          ..write('id: $id, ')
          ..write('damageId: $damageId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitCost: $unitCost, ')
          ..write('lineCost: $lineCost, ')
          ..write('reason: $reason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpenseCategoriesTable extends ExpenseCategories
    with TableInfo<$ExpenseCategoriesTable, ExpenseCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMmMeta = const VerificationMeta('nameMm');
  @override
  late final GeneratedColumn<String> nameMm = GeneratedColumn<String>(
    'name_mm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    nameEn,
    nameMm,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('name_mm')) {
      context.handle(
        _nameMmMeta,
        nameMm.isAcceptableOrUnknown(data['name_mm']!, _nameMmMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      nameMm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_mm'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExpenseCategoriesTable createAlias(String alias) {
    return $ExpenseCategoriesTable(attachedDatabase, alias);
  }
}

class ExpenseCategory extends DataClass implements Insertable<ExpenseCategory> {
  final String id;
  final String shopId;
  final String? nameEn;
  final String? nameMm;
  final String syncStatus;
  final DateTime updatedAt;
  const ExpenseCategory({
    required this.id,
    required this.shopId,
    this.nameEn,
    this.nameMm,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameMm != null) {
      map['name_mm'] = Variable<String>(nameMm);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExpenseCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ExpenseCategoriesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      nameMm: nameMm == null && nullToAbsent
          ? const Value.absent()
          : Value(nameMm),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExpenseCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseCategory(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameMm: serializer.fromJson<String?>(json['nameMm']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameMm': serializer.toJson<String?>(nameMm),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExpenseCategory copyWith({
    String? id,
    String? shopId,
    Value<String?> nameEn = const Value.absent(),
    Value<String?> nameMm = const Value.absent(),
    String? syncStatus,
    DateTime? updatedAt,
  }) => ExpenseCategory(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    nameMm: nameMm.present ? nameMm.value : this.nameMm,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ExpenseCategory copyWithCompanion(ExpenseCategoriesCompanion data) {
    return ExpenseCategory(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameMm: data.nameMm.present ? data.nameMm.value : this.nameMm,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategory(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, shopId, nameEn, nameMm, syncStatus, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseCategory &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.nameEn == this.nameEn &&
          other.nameMm == this.nameMm &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class ExpenseCategoriesCompanion extends UpdateCompanion<ExpenseCategory> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String?> nameEn;
  final Value<String?> nameMm;
  final Value<String> syncStatus;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExpenseCategoriesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpenseCategoriesCompanion.insert({
    required String id,
    required String shopId,
    this.nameEn = const Value.absent(),
    this.nameMm = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       updatedAt = Value(updatedAt);
  static Insertable<ExpenseCategory> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? nameEn,
    Expression<String>? nameMm,
    Expression<String>? syncStatus,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (nameEn != null) 'name_en': nameEn,
      if (nameMm != null) 'name_mm': nameMm,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpenseCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String?>? nameEn,
    Value<String?>? nameMm,
    Value<String>? syncStatus,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExpenseCategoriesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      nameEn: nameEn ?? this.nameEn,
      nameMm: nameMm ?? this.nameMm,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameMm.present) {
      map['name_mm'] = Variable<String>(nameMm.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameMm: $nameMm, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expenseCategoryIdMeta = const VerificationMeta(
    'expenseCategoryId',
  );
  @override
  late final GeneratedColumn<String> expenseCategoryId =
      GeneratedColumn<String>(
        'expense_category_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spentAtMeta = const VerificationMeta(
    'spentAt',
  );
  @override
  late final GeneratedColumn<DateTime> spentAt = GeneratedColumn<DateTime>(
    'spent_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    deviceId,
    staffId,
    expenseCategoryId,
    title,
    amount,
    spentAt,
    note,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('expense_category_id')) {
      context.handle(
        _expenseCategoryIdMeta,
        expenseCategoryId.isAcceptableOrUnknown(
          data['expense_category_id']!,
          _expenseCategoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expenseCategoryIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('spent_at')) {
      context.handle(
        _spentAtMeta,
        spentAt.isAcceptableOrUnknown(data['spent_at']!, _spentAtMeta),
      );
    } else if (isInserting) {
      context.missing(_spentAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      expenseCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expense_category_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      spentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}spent_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final String shopId;
  final String deviceId;
  final String staffId;
  final String expenseCategoryId;
  final String title;
  final double amount;
  final DateTime spentAt;
  final String? note;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Expense({
    required this.id,
    required this.shopId,
    required this.deviceId,
    required this.staffId,
    required this.expenseCategoryId,
    required this.title,
    required this.amount,
    required this.spentAt,
    this.note,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['device_id'] = Variable<String>(deviceId);
    map['staff_id'] = Variable<String>(staffId);
    map['expense_category_id'] = Variable<String>(expenseCategoryId);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['spent_at'] = Variable<DateTime>(spentAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      deviceId: Value(deviceId),
      staffId: Value(staffId),
      expenseCategoryId: Value(expenseCategoryId),
      title: Value(title),
      amount: Value(amount),
      spentAt: Value(spentAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      expenseCategoryId: serializer.fromJson<String>(json['expenseCategoryId']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      spentAt: serializer.fromJson<DateTime>(json['spentAt']),
      note: serializer.fromJson<String?>(json['note']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'deviceId': serializer.toJson<String>(deviceId),
      'staffId': serializer.toJson<String>(staffId),
      'expenseCategoryId': serializer.toJson<String>(expenseCategoryId),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'spentAt': serializer.toJson<DateTime>(spentAt),
      'note': serializer.toJson<String?>(note),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Expense copyWith({
    String? id,
    String? shopId,
    String? deviceId,
    String? staffId,
    String? expenseCategoryId,
    String? title,
    double? amount,
    DateTime? spentAt,
    Value<String?> note = const Value.absent(),
    String? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Expense(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    deviceId: deviceId ?? this.deviceId,
    staffId: staffId ?? this.staffId,
    expenseCategoryId: expenseCategoryId ?? this.expenseCategoryId,
    title: title ?? this.title,
    amount: amount ?? this.amount,
    spentAt: spentAt ?? this.spentAt,
    note: note.present ? note.value : this.note,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      expenseCategoryId: data.expenseCategoryId.present
          ? data.expenseCategoryId.value
          : this.expenseCategoryId,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      spentAt: data.spentAt.present ? data.spentAt.value : this.spentAt,
      note: data.note.present ? data.note.value : this.note,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('deviceId: $deviceId, ')
          ..write('staffId: $staffId, ')
          ..write('expenseCategoryId: $expenseCategoryId, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('spentAt: $spentAt, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    deviceId,
    staffId,
    expenseCategoryId,
    title,
    amount,
    spentAt,
    note,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.deviceId == this.deviceId &&
          other.staffId == this.staffId &&
          other.expenseCategoryId == this.expenseCategoryId &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.spentAt == this.spentAt &&
          other.note == this.note &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> deviceId;
  final Value<String> staffId;
  final Value<String> expenseCategoryId;
  final Value<String> title;
  final Value<double> amount;
  final Value<DateTime> spentAt;
  final Value<String?> note;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.expenseCategoryId = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.spentAt = const Value.absent(),
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required String shopId,
    required String deviceId,
    required String staffId,
    required String expenseCategoryId,
    required String title,
    required double amount,
    required DateTime spentAt,
    this.note = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       deviceId = Value(deviceId),
       staffId = Value(staffId),
       expenseCategoryId = Value(expenseCategoryId),
       title = Value(title),
       amount = Value(amount),
       spentAt = Value(spentAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? deviceId,
    Expression<String>? staffId,
    Expression<String>? expenseCategoryId,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<DateTime>? spentAt,
    Expression<String>? note,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (deviceId != null) 'device_id': deviceId,
      if (staffId != null) 'staff_id': staffId,
      if (expenseCategoryId != null) 'expense_category_id': expenseCategoryId,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (spentAt != null) 'spent_at': spentAt,
      if (note != null) 'note': note,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? deviceId,
    Value<String>? staffId,
    Value<String>? expenseCategoryId,
    Value<String>? title,
    Value<double>? amount,
    Value<DateTime>? spentAt,
    Value<String?>? note,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      deviceId: deviceId ?? this.deviceId,
      staffId: staffId ?? this.staffId,
      expenseCategoryId: expenseCategoryId ?? this.expenseCategoryId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      spentAt: spentAt ?? this.spentAt,
      note: note ?? this.note,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (expenseCategoryId.present) {
      map['expense_category_id'] = Variable<String>(expenseCategoryId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (spentAt.present) {
      map['spent_at'] = Variable<DateTime>(spentAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('deviceId: $deviceId, ')
          ..write('staffId: $staffId, ')
          ..write('expenseCategoryId: $expenseCategoryId, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('spentAt: $spentAt, ')
          ..write('note: $note, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepurchasesTable extends Repurchases
    with TableInfo<$RepurchasesTable, Repurchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repurchaseNoMeta = const VerificationMeta(
    'repurchaseNo',
  );
  @override
  late final GeneratedColumn<String> repurchaseNo = GeneratedColumn<String>(
    'repurchase_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('open'),
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<String> purchaseId = GeneratedColumn<String>(
    'purchase_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    repurchaseNo,
    status,
    purchaseId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repurchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Repurchase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('repurchase_no')) {
      context.handle(
        _repurchaseNoMeta,
        repurchaseNo.isAcceptableOrUnknown(
          data['repurchase_no']!,
          _repurchaseNoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repurchaseNoMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Repurchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Repurchase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      repurchaseNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repurchase_no'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RepurchasesTable createAlias(String alias) {
    return $RepurchasesTable(attachedDatabase, alias);
  }
}

class Repurchase extends DataClass implements Insertable<Repurchase> {
  final String id;
  final String shopId;
  final String repurchaseNo;
  final String status;
  final String? purchaseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Repurchase({
    required this.id,
    required this.shopId,
    required this.repurchaseNo,
    required this.status,
    this.purchaseId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['repurchase_no'] = Variable<String>(repurchaseNo);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || purchaseId != null) {
      map['purchase_id'] = Variable<String>(purchaseId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RepurchasesCompanion toCompanion(bool nullToAbsent) {
    return RepurchasesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      repurchaseNo: Value(repurchaseNo),
      status: Value(status),
      purchaseId: purchaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Repurchase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Repurchase(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      repurchaseNo: serializer.fromJson<String>(json['repurchaseNo']),
      status: serializer.fromJson<String>(json['status']),
      purchaseId: serializer.fromJson<String?>(json['purchaseId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'repurchaseNo': serializer.toJson<String>(repurchaseNo),
      'status': serializer.toJson<String>(status),
      'purchaseId': serializer.toJson<String?>(purchaseId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Repurchase copyWith({
    String? id,
    String? shopId,
    String? repurchaseNo,
    String? status,
    Value<String?> purchaseId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Repurchase(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    repurchaseNo: repurchaseNo ?? this.repurchaseNo,
    status: status ?? this.status,
    purchaseId: purchaseId.present ? purchaseId.value : this.purchaseId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Repurchase copyWithCompanion(RepurchasesCompanion data) {
    return Repurchase(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      repurchaseNo: data.repurchaseNo.present
          ? data.repurchaseNo.value
          : this.repurchaseNo,
      status: data.status.present ? data.status.value : this.status,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Repurchase(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('repurchaseNo: $repurchaseNo, ')
          ..write('status: $status, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    repurchaseNo,
    status,
    purchaseId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Repurchase &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.repurchaseNo == this.repurchaseNo &&
          other.status == this.status &&
          other.purchaseId == this.purchaseId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RepurchasesCompanion extends UpdateCompanion<Repurchase> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> repurchaseNo;
  final Value<String> status;
  final Value<String?> purchaseId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RepurchasesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.repurchaseNo = const Value.absent(),
    this.status = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepurchasesCompanion.insert({
    required String id,
    required String shopId,
    required String repurchaseNo,
    this.status = const Value.absent(),
    this.purchaseId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       repurchaseNo = Value(repurchaseNo),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Repurchase> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? repurchaseNo,
    Expression<String>? status,
    Expression<String>? purchaseId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (repurchaseNo != null) 'repurchase_no': repurchaseNo,
      if (status != null) 'status': status,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepurchasesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? repurchaseNo,
    Value<String>? status,
    Value<String?>? purchaseId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RepurchasesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      repurchaseNo: repurchaseNo ?? this.repurchaseNo,
      status: status ?? this.status,
      purchaseId: purchaseId ?? this.purchaseId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (repurchaseNo.present) {
      map['repurchase_no'] = Variable<String>(repurchaseNo.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<String>(purchaseId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepurchasesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('repurchaseNo: $repurchaseNo, ')
          ..write('status: $status, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepurchaseItemsTable extends RepurchaseItems
    with TableInfo<$RepurchaseItemsTable, RepurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepurchaseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repurchaseIdMeta = const VerificationMeta(
    'repurchaseId',
  );
  @override
  late final GeneratedColumn<String> repurchaseId = GeneratedColumn<String>(
    'repurchase_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<double> qty = GeneratedColumn<double>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _packQtyMeta = const VerificationMeta(
    'packQty',
  );
  @override
  late final GeneratedColumn<double> packQty = GeneratedColumn<double>(
    'pack_qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _packSizeMeta = const VerificationMeta(
    'packSize',
  );
  @override
  late final GeneratedColumn<double> packSize = GeneratedColumn<double>(
    'pack_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    repurchaseId,
    productId,
    qty,
    packQty,
    packSize,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repurchase_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepurchaseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('repurchase_id')) {
      context.handle(
        _repurchaseIdMeta,
        repurchaseId.isAcceptableOrUnknown(
          data['repurchase_id']!,
          _repurchaseIdMeta,
        ),
      );
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    }
    if (data.containsKey('pack_qty')) {
      context.handle(
        _packQtyMeta,
        packQty.isAcceptableOrUnknown(data['pack_qty']!, _packQtyMeta),
      );
    }
    if (data.containsKey('pack_size')) {
      context.handle(
        _packSizeMeta,
        packSize.isAcceptableOrUnknown(data['pack_size']!, _packSizeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepurchaseItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      repurchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repurchase_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty'],
      )!,
      packQty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pack_qty'],
      )!,
      packSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pack_size'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RepurchaseItemsTable createAlias(String alias) {
    return $RepurchaseItemsTable(attachedDatabase, alias);
  }
}

class RepurchaseItem extends DataClass implements Insertable<RepurchaseItem> {
  final String id;
  final String shopId;
  final String repurchaseId;
  final String productId;
  final double qty;
  final double packQty;
  final double packSize;
  final DateTime createdAt;
  const RepurchaseItem({
    required this.id,
    required this.shopId,
    required this.repurchaseId,
    required this.productId,
    required this.qty,
    required this.packQty,
    required this.packSize,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['repurchase_id'] = Variable<String>(repurchaseId);
    map['product_id'] = Variable<String>(productId);
    map['qty'] = Variable<double>(qty);
    map['pack_qty'] = Variable<double>(packQty);
    map['pack_size'] = Variable<double>(packSize);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RepurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return RepurchaseItemsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      repurchaseId: Value(repurchaseId),
      productId: Value(productId),
      qty: Value(qty),
      packQty: Value(packQty),
      packSize: Value(packSize),
      createdAt: Value(createdAt),
    );
  }

  factory RepurchaseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepurchaseItem(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      repurchaseId: serializer.fromJson<String>(json['repurchaseId']),
      productId: serializer.fromJson<String>(json['productId']),
      qty: serializer.fromJson<double>(json['qty']),
      packQty: serializer.fromJson<double>(json['packQty']),
      packSize: serializer.fromJson<double>(json['packSize']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'repurchaseId': serializer.toJson<String>(repurchaseId),
      'productId': serializer.toJson<String>(productId),
      'qty': serializer.toJson<double>(qty),
      'packQty': serializer.toJson<double>(packQty),
      'packSize': serializer.toJson<double>(packSize),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RepurchaseItem copyWith({
    String? id,
    String? shopId,
    String? repurchaseId,
    String? productId,
    double? qty,
    double? packQty,
    double? packSize,
    DateTime? createdAt,
  }) => RepurchaseItem(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    repurchaseId: repurchaseId ?? this.repurchaseId,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
    packQty: packQty ?? this.packQty,
    packSize: packSize ?? this.packSize,
    createdAt: createdAt ?? this.createdAt,
  );
  RepurchaseItem copyWithCompanion(RepurchaseItemsCompanion data) {
    return RepurchaseItem(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      repurchaseId: data.repurchaseId.present
          ? data.repurchaseId.value
          : this.repurchaseId,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
      packQty: data.packQty.present ? data.packQty.value : this.packQty,
      packSize: data.packSize.present ? data.packSize.value : this.packSize,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepurchaseItem(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('repurchaseId: $repurchaseId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('packQty: $packQty, ')
          ..write('packSize: $packSize, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    repurchaseId,
    productId,
    qty,
    packQty,
    packSize,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepurchaseItem &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.repurchaseId == this.repurchaseId &&
          other.productId == this.productId &&
          other.qty == this.qty &&
          other.packQty == this.packQty &&
          other.packSize == this.packSize &&
          other.createdAt == this.createdAt);
}

class RepurchaseItemsCompanion extends UpdateCompanion<RepurchaseItem> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> repurchaseId;
  final Value<String> productId;
  final Value<double> qty;
  final Value<double> packQty;
  final Value<double> packSize;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RepurchaseItemsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.repurchaseId = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.packQty = const Value.absent(),
    this.packSize = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepurchaseItemsCompanion.insert({
    required String id,
    required String shopId,
    this.repurchaseId = const Value.absent(),
    required String productId,
    this.qty = const Value.absent(),
    this.packQty = const Value.absent(),
    this.packSize = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       productId = Value(productId),
       createdAt = Value(createdAt);
  static Insertable<RepurchaseItem> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? repurchaseId,
    Expression<String>? productId,
    Expression<double>? qty,
    Expression<double>? packQty,
    Expression<double>? packSize,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (repurchaseId != null) 'repurchase_id': repurchaseId,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (packQty != null) 'pack_qty': packQty,
      if (packSize != null) 'pack_size': packSize,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepurchaseItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? repurchaseId,
    Value<String>? productId,
    Value<double>? qty,
    Value<double>? packQty,
    Value<double>? packSize,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RepurchaseItemsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      repurchaseId: repurchaseId ?? this.repurchaseId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      packQty: packQty ?? this.packQty,
      packSize: packSize ?? this.packSize,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (repurchaseId.present) {
      map['repurchase_id'] = Variable<String>(repurchaseId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<double>(qty.value);
    }
    if (packQty.present) {
      map['pack_qty'] = Variable<double>(packQty.value);
    }
    if (packSize.present) {
      map['pack_size'] = Variable<double>(packSize.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepurchaseItemsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('repurchaseId: $repurchaseId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('packQty: $packQty, ')
          ..write('packSize: $packSize, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements
    with TableInfo<$StockMovementsTable, StockMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyChangeMeta = const VerificationMeta(
    'qtyChange',
  );
  @override
  late final GeneratedColumn<double> qtyChange = GeneratedColumn<double>(
    'qty_change',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMeta = const VerificationMeta(
    'unitCost',
  );
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
    'unit_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _happenedAtMeta = const VerificationMeta(
    'happenedAt',
  );
  @override
  late final GeneratedColumn<DateTime> happenedAt = GeneratedColumn<DateTime>(
    'happened_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    productId,
    sourceType,
    sourceId,
    qtyChange,
    unitCost,
    happenedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('qty_change')) {
      context.handle(
        _qtyChangeMeta,
        qtyChange.isAcceptableOrUnknown(data['qty_change']!, _qtyChangeMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyChangeMeta);
    }
    if (data.containsKey('unit_cost')) {
      context.handle(
        _unitCostMeta,
        unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta),
      );
    } else if (isInserting) {
      context.missing(_unitCostMeta);
    }
    if (data.containsKey('happened_at')) {
      context.handle(
        _happenedAtMeta,
        happenedAt.isAcceptableOrUnknown(data['happened_at']!, _happenedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_happenedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      qtyChange: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty_change'],
      )!,
      unitCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost'],
      )!,
      happenedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}happened_at'],
      )!,
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovement extends DataClass implements Insertable<StockMovement> {
  final String id;
  final String shopId;
  final String productId;
  final String sourceType;
  final String sourceId;
  final double qtyChange;
  final double unitCost;
  final DateTime happenedAt;
  const StockMovement({
    required this.id,
    required this.shopId,
    required this.productId,
    required this.sourceType,
    required this.sourceId,
    required this.qtyChange,
    required this.unitCost,
    required this.happenedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['product_id'] = Variable<String>(productId);
    map['source_type'] = Variable<String>(sourceType);
    map['source_id'] = Variable<String>(sourceId);
    map['qty_change'] = Variable<double>(qtyChange);
    map['unit_cost'] = Variable<double>(unitCost);
    map['happened_at'] = Variable<DateTime>(happenedAt);
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      productId: Value(productId),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      qtyChange: Value(qtyChange),
      unitCost: Value(unitCost),
      happenedAt: Value(happenedAt),
    );
  }

  factory StockMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovement(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      productId: serializer.fromJson<String>(json['productId']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      qtyChange: serializer.fromJson<double>(json['qtyChange']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
      happenedAt: serializer.fromJson<DateTime>(json['happenedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'productId': serializer.toJson<String>(productId),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
      'qtyChange': serializer.toJson<double>(qtyChange),
      'unitCost': serializer.toJson<double>(unitCost),
      'happenedAt': serializer.toJson<DateTime>(happenedAt),
    };
  }

  StockMovement copyWith({
    String? id,
    String? shopId,
    String? productId,
    String? sourceType,
    String? sourceId,
    double? qtyChange,
    double? unitCost,
    DateTime? happenedAt,
  }) => StockMovement(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    productId: productId ?? this.productId,
    sourceType: sourceType ?? this.sourceType,
    sourceId: sourceId ?? this.sourceId,
    qtyChange: qtyChange ?? this.qtyChange,
    unitCost: unitCost ?? this.unitCost,
    happenedAt: happenedAt ?? this.happenedAt,
  );
  StockMovement copyWithCompanion(StockMovementsCompanion data) {
    return StockMovement(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      productId: data.productId.present ? data.productId.value : this.productId,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      qtyChange: data.qtyChange.present ? data.qtyChange.value : this.qtyChange,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
      happenedAt: data.happenedAt.present
          ? data.happenedAt.value
          : this.happenedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovement(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('productId: $productId, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('qtyChange: $qtyChange, ')
          ..write('unitCost: $unitCost, ')
          ..write('happenedAt: $happenedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    productId,
    sourceType,
    sourceId,
    qtyChange,
    unitCost,
    happenedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovement &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.productId == this.productId &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.qtyChange == this.qtyChange &&
          other.unitCost == this.unitCost &&
          other.happenedAt == this.happenedAt);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovement> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> productId;
  final Value<String> sourceType;
  final Value<String> sourceId;
  final Value<double> qtyChange;
  final Value<double> unitCost;
  final Value<DateTime> happenedAt;
  final Value<int> rowid;
  const StockMovementsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.productId = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.qtyChange = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.happenedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    required String id,
    required String shopId,
    required String productId,
    required String sourceType,
    required String sourceId,
    required double qtyChange,
    required double unitCost,
    required DateTime happenedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       productId = Value(productId),
       sourceType = Value(sourceType),
       sourceId = Value(sourceId),
       qtyChange = Value(qtyChange),
       unitCost = Value(unitCost),
       happenedAt = Value(happenedAt);
  static Insertable<StockMovement> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? productId,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<double>? qtyChange,
    Expression<double>? unitCost,
    Expression<DateTime>? happenedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (productId != null) 'product_id': productId,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (qtyChange != null) 'qty_change': qtyChange,
      if (unitCost != null) 'unit_cost': unitCost,
      if (happenedAt != null) 'happened_at': happenedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockMovementsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? productId,
    Value<String>? sourceType,
    Value<String>? sourceId,
    Value<double>? qtyChange,
    Value<double>? unitCost,
    Value<DateTime>? happenedAt,
    Value<int>? rowid,
  }) {
    return StockMovementsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      productId: productId ?? this.productId,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      qtyChange: qtyChange ?? this.qtyChange,
      unitCost: unitCost ?? this.unitCost,
      happenedAt: happenedAt ?? this.happenedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (qtyChange.present) {
      map['qty_change'] = Variable<double>(qtyChange.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (happenedAt.present) {
      map['happened_at'] = Variable<DateTime>(happenedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('productId: $productId, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('qtyChange: $qtyChange, ')
          ..write('unitCost: $unitCost, ')
          ..write('happenedAt: $happenedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeveloperReportsTable extends DeveloperReports
    with TableInfo<$DeveloperReportsTable, DeveloperReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeveloperReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, message, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'developer_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeveloperReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeveloperReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeveloperReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DeveloperReportsTable createAlias(String alias) {
    return $DeveloperReportsTable(attachedDatabase, alias);
  }
}

class DeveloperReport extends DataClass implements Insertable<DeveloperReport> {
  final String id;
  final String message;
  final DateTime createdAt;
  const DeveloperReport({
    required this.id,
    required this.message,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['message'] = Variable<String>(message);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DeveloperReportsCompanion toCompanion(bool nullToAbsent) {
    return DeveloperReportsCompanion(
      id: Value(id),
      message: Value(message),
      createdAt: Value(createdAt),
    );
  }

  factory DeveloperReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeveloperReport(
      id: serializer.fromJson<String>(json['id']),
      message: serializer.fromJson<String>(json['message']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'message': serializer.toJson<String>(message),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DeveloperReport copyWith({
    String? id,
    String? message,
    DateTime? createdAt,
  }) => DeveloperReport(
    id: id ?? this.id,
    message: message ?? this.message,
    createdAt: createdAt ?? this.createdAt,
  );
  DeveloperReport copyWithCompanion(DeveloperReportsCompanion data) {
    return DeveloperReport(
      id: data.id.present ? data.id.value : this.id,
      message: data.message.present ? data.message.value : this.message,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeveloperReport(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, message, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeveloperReport &&
          other.id == this.id &&
          other.message == this.message &&
          other.createdAt == this.createdAt);
}

class DeveloperReportsCompanion extends UpdateCompanion<DeveloperReport> {
  final Value<String> id;
  final Value<String> message;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DeveloperReportsCompanion({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeveloperReportsCompanion.insert({
    required String id,
    required String message,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       message = Value(message),
       createdAt = Value(createdAt);
  static Insertable<DeveloperReport> custom({
    Expression<String>? id,
    Expression<String>? message,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeveloperReportsCompanion copyWith({
    Value<String>? id,
    Value<String>? message,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DeveloperReportsCompanion(
      id: id ?? this.id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeveloperReportsCompanion(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ShopsTable shops = $ShopsTable(this);
  late final $DevicesTable devices = $DevicesTable(this);
  late final $StaffTable staff = $StaffTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $UnitsTable units = $UnitsTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $PurchaseLinesTable purchaseLines = $PurchaseLinesTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleLinesTable saleLines = $SaleLinesTable(this);
  late final $DamagesTable damages = $DamagesTable(this);
  late final $DamageLinesTable damageLines = $DamageLinesTable(this);
  late final $ExpenseCategoriesTable expenseCategories =
      $ExpenseCategoriesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $RepurchasesTable repurchases = $RepurchasesTable(this);
  late final $RepurchaseItemsTable repurchaseItems = $RepurchaseItemsTable(
    this,
  );
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $DeveloperReportsTable developerReports = $DeveloperReportsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    shops,
    devices,
    staff,
    categories,
    units,
    products,
    suppliers,
    purchases,
    purchaseLines,
    sales,
    saleLines,
    damages,
    damageLines,
    expenseCategories,
    expenses,
    repurchases,
    repurchaseItems,
    stockMovements,
    developerReports,
  ];
}

typedef $$ShopsTableCreateCompanionBuilder =
    ShopsCompanion Function({
      required String id,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String> receiptLanguage,
      Value<String> currency,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ShopsTableUpdateCompanionBuilder =
    ShopsCompanion Function({
      Value<String> id,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String> receiptLanguage,
      Value<String> currency,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ShopsTableFilterComposer extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptLanguage => $composableBuilder(
    column: $table.receiptLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptLanguage => $composableBuilder(
    column: $table.receiptLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameMm =>
      $composableBuilder(column: $table.nameMm, builder: (column) => column);

  GeneratedColumn<String> get receiptLanguage => $composableBuilder(
    column: $table.receiptLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ShopsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopsTable,
          Shop,
          $$ShopsTableFilterComposer,
          $$ShopsTableOrderingComposer,
          $$ShopsTableAnnotationComposer,
          $$ShopsTableCreateCompanionBuilder,
          $$ShopsTableUpdateCompanionBuilder,
          (Shop, BaseReferences<_$AppDatabase, $ShopsTable, Shop>),
          Shop,
          PrefetchHooks Function()
        > {
  $$ShopsTableTableManager(_$AppDatabase db, $ShopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String> receiptLanguage = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion(
                id: id,
                nameEn: nameEn,
                nameMm: nameMm,
                receiptLanguage: receiptLanguage,
                currency: currency,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String> receiptLanguage = const Value.absent(),
                Value<String> currency = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameMm: nameMm,
                receiptLanguage: receiptLanguage,
                currency: currency,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopsTable,
      Shop,
      $$ShopsTableFilterComposer,
      $$ShopsTableOrderingComposer,
      $$ShopsTableAnnotationComposer,
      $$ShopsTableCreateCompanionBuilder,
      $$ShopsTableUpdateCompanionBuilder,
      (Shop, BaseReferences<_$AppDatabase, $ShopsTable, Shop>),
      Shop,
      PrefetchHooks Function()
    >;
typedef $$DevicesTableCreateCompanionBuilder =
    DevicesCompanion Function({
      required String id,
      required String shopId,
      required String name,
      required String platform,
      Value<String> language,
      Value<String> themeMode,
      Value<String> themeColor,
      Value<DateTime?> lastSyncAt,
      Value<String?> supabaseUrl,
      Value<String?> supabaseKey,
      Value<int> rowid,
    });
typedef $$DevicesTableUpdateCompanionBuilder =
    DevicesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> name,
      Value<String> platform,
      Value<String> language,
      Value<String> themeMode,
      Value<String> themeColor,
      Value<DateTime?> lastSyncAt,
      Value<String?> supabaseUrl,
      Value<String?> supabaseKey,
      Value<int> rowid,
    });

class $$DevicesTableFilterComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supabaseUrl => $composableBuilder(
    column: $table.supabaseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supabaseKey => $composableBuilder(
    column: $table.supabaseKey,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supabaseUrl => $composableBuilder(
    column: $table.supabaseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supabaseKey => $composableBuilder(
    column: $table.supabaseKey,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supabaseUrl => $composableBuilder(
    column: $table.supabaseUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supabaseKey => $composableBuilder(
    column: $table.supabaseKey,
    builder: (column) => column,
  );
}

class $$DevicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DevicesTable,
          Device,
          $$DevicesTableFilterComposer,
          $$DevicesTableOrderingComposer,
          $$DevicesTableAnnotationComposer,
          $$DevicesTableCreateCompanionBuilder,
          $$DevicesTableUpdateCompanionBuilder,
          (Device, BaseReferences<_$AppDatabase, $DevicesTable, Device>),
          Device,
          PrefetchHooks Function()
        > {
  $$DevicesTableTableManager(_$AppDatabase db, $DevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> platform = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> themeColor = const Value.absent(),
                Value<DateTime?> lastSyncAt = const Value.absent(),
                Value<String?> supabaseUrl = const Value.absent(),
                Value<String?> supabaseKey = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion(
                id: id,
                shopId: shopId,
                name: name,
                platform: platform,
                language: language,
                themeMode: themeMode,
                themeColor: themeColor,
                lastSyncAt: lastSyncAt,
                supabaseUrl: supabaseUrl,
                supabaseKey: supabaseKey,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String name,
                required String platform,
                Value<String> language = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> themeColor = const Value.absent(),
                Value<DateTime?> lastSyncAt = const Value.absent(),
                Value<String?> supabaseUrl = const Value.absent(),
                Value<String?> supabaseKey = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion.insert(
                id: id,
                shopId: shopId,
                name: name,
                platform: platform,
                language: language,
                themeMode: themeMode,
                themeColor: themeColor,
                lastSyncAt: lastSyncAt,
                supabaseUrl: supabaseUrl,
                supabaseKey: supabaseKey,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DevicesTable,
      Device,
      $$DevicesTableFilterComposer,
      $$DevicesTableOrderingComposer,
      $$DevicesTableAnnotationComposer,
      $$DevicesTableCreateCompanionBuilder,
      $$DevicesTableUpdateCompanionBuilder,
      (Device, BaseReferences<_$AppDatabase, $DevicesTable, Device>),
      Device,
      PrefetchHooks Function()
    >;
typedef $$StaffTableCreateCompanionBuilder =
    StaffCompanion Function({
      required String id,
      required String shopId,
      required String name,
      required String role,
      required String pinHash,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$StaffTableUpdateCompanionBuilder =
    StaffCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> name,
      Value<String> role,
      Value<String> pinHash,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$StaffTableFilterComposer extends Composer<_$AppDatabase, $StaffTable> {
  $$StaffTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StaffTableOrderingComposer
    extends Composer<_$AppDatabase, $StaffTable> {
  $$StaffTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StaffTableAnnotationComposer
    extends Composer<_$AppDatabase, $StaffTable> {
  $$StaffTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$StaffTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StaffTable,
          StaffData,
          $$StaffTableFilterComposer,
          $$StaffTableOrderingComposer,
          $$StaffTableAnnotationComposer,
          $$StaffTableCreateCompanionBuilder,
          $$StaffTableUpdateCompanionBuilder,
          (StaffData, BaseReferences<_$AppDatabase, $StaffTable, StaffData>),
          StaffData,
          PrefetchHooks Function()
        > {
  $$StaffTableTableManager(_$AppDatabase db, $StaffTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> pinHash = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StaffCompanion(
                id: id,
                shopId: shopId,
                name: name,
                role: role,
                pinHash: pinHash,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String name,
                required String role,
                required String pinHash,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StaffCompanion.insert(
                id: id,
                shopId: shopId,
                name: name,
                role: role,
                pinHash: pinHash,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StaffTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StaffTable,
      StaffData,
      $$StaffTableFilterComposer,
      $$StaffTableOrderingComposer,
      $$StaffTableAnnotationComposer,
      $$StaffTableCreateCompanionBuilder,
      $$StaffTableUpdateCompanionBuilder,
      (StaffData, BaseReferences<_$AppDatabase, $StaffTable, StaffData>),
      StaffData,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      required String shopId,
      Value<String?> parentId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<String?> deviceId,
      Value<String> syncStatus,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String?> parentId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<String?> deviceId,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameMm =>
      $composableBuilder(column: $table.nameMm, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                shopId: shopId,
                parentId: parentId,
                nameEn: nameEn,
                nameMm: nameMm,
                sortOrder: sortOrder,
                isActive: isActive,
                deviceId: deviceId,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                Value<String?> parentId = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                shopId: shopId,
                parentId: parentId,
                nameEn: nameEn,
                nameMm: nameMm,
                sortOrder: sortOrder,
                isActive: isActive,
                deviceId: deviceId,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$UnitsTableCreateCompanionBuilder =
    UnitsCompanion Function({
      required String id,
      required String shopId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String> syncStatus,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UnitsTableUpdateCompanionBuilder =
    UnitsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UnitsTableFilterComposer extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameMm =>
      $composableBuilder(column: $table.nameMm, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnitsTable,
          Unit,
          $$UnitsTableFilterComposer,
          $$UnitsTableOrderingComposer,
          $$UnitsTableAnnotationComposer,
          $$UnitsTableCreateCompanionBuilder,
          $$UnitsTableUpdateCompanionBuilder,
          (Unit, BaseReferences<_$AppDatabase, $UnitsTable, Unit>),
          Unit,
          PrefetchHooks Function()
        > {
  $$UnitsTableTableManager(_$AppDatabase db, $UnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UnitsCompanion(
                id: id,
                shopId: shopId,
                nameEn: nameEn,
                nameMm: nameMm,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UnitsCompanion.insert(
                id: id,
                shopId: shopId,
                nameEn: nameEn,
                nameMm: nameMm,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnitsTable,
      Unit,
      $$UnitsTableFilterComposer,
      $$UnitsTableOrderingComposer,
      $$UnitsTableAnnotationComposer,
      $$UnitsTableCreateCompanionBuilder,
      $$UnitsTableUpdateCompanionBuilder,
      (Unit, BaseReferences<_$AppDatabase, $UnitsTable, Unit>),
      Unit,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String id,
      required String shopId,
      required String categoryId,
      required String unitId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String?> barcode,
      Value<String?> sku,
      Value<double> cost,
      required double price,
      Value<double?> packSize,
      Value<double?> packPrice,
      Value<double?> buyPrice,
      Value<double?> packBuyPrice,
      Value<double?> previousPrice,
      Value<double?> previousPackPrice,
      Value<double?> reorderLevel,
      Value<bool> isActive,
      Value<String?> deviceId,
      Value<String> syncStatus,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> categoryId,
      Value<String> unitId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String?> barcode,
      Value<String?> sku,
      Value<double> cost,
      Value<double> price,
      Value<double?> packSize,
      Value<double?> packPrice,
      Value<double?> buyPrice,
      Value<double?> packBuyPrice,
      Value<double?> previousPrice,
      Value<double?> previousPackPrice,
      Value<double?> reorderLevel,
      Value<bool> isActive,
      Value<String?> deviceId,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packPrice => $composableBuilder(
    column: $table.packPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get buyPrice => $composableBuilder(
    column: $table.buyPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packBuyPrice => $composableBuilder(
    column: $table.packBuyPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get previousPrice => $composableBuilder(
    column: $table.previousPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get previousPackPrice => $composableBuilder(
    column: $table.previousPackPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packPrice => $composableBuilder(
    column: $table.packPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get buyPrice => $composableBuilder(
    column: $table.buyPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packBuyPrice => $composableBuilder(
    column: $table.packBuyPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get previousPrice => $composableBuilder(
    column: $table.previousPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get previousPackPrice => $composableBuilder(
    column: $table.previousPackPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameMm =>
      $composableBuilder(column: $table.nameMm, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get packSize =>
      $composableBuilder(column: $table.packSize, builder: (column) => column);

  GeneratedColumn<double> get packPrice =>
      $composableBuilder(column: $table.packPrice, builder: (column) => column);

  GeneratedColumn<double> get buyPrice =>
      $composableBuilder(column: $table.buyPrice, builder: (column) => column);

  GeneratedColumn<double> get packBuyPrice => $composableBuilder(
    column: $table.packBuyPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get previousPrice => $composableBuilder(
    column: $table.previousPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get previousPackPrice => $composableBuilder(
    column: $table.previousPackPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> unitId = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<double> cost = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> packSize = const Value.absent(),
                Value<double?> packPrice = const Value.absent(),
                Value<double?> buyPrice = const Value.absent(),
                Value<double?> packBuyPrice = const Value.absent(),
                Value<double?> previousPrice = const Value.absent(),
                Value<double?> previousPackPrice = const Value.absent(),
                Value<double?> reorderLevel = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                shopId: shopId,
                categoryId: categoryId,
                unitId: unitId,
                nameEn: nameEn,
                nameMm: nameMm,
                barcode: barcode,
                sku: sku,
                cost: cost,
                price: price,
                packSize: packSize,
                packPrice: packPrice,
                buyPrice: buyPrice,
                packBuyPrice: packBuyPrice,
                previousPrice: previousPrice,
                previousPackPrice: previousPackPrice,
                reorderLevel: reorderLevel,
                isActive: isActive,
                deviceId: deviceId,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String categoryId,
                required String unitId,
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<double> cost = const Value.absent(),
                required double price,
                Value<double?> packSize = const Value.absent(),
                Value<double?> packPrice = const Value.absent(),
                Value<double?> buyPrice = const Value.absent(),
                Value<double?> packBuyPrice = const Value.absent(),
                Value<double?> previousPrice = const Value.absent(),
                Value<double?> previousPackPrice = const Value.absent(),
                Value<double?> reorderLevel = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                shopId: shopId,
                categoryId: categoryId,
                unitId: unitId,
                nameEn: nameEn,
                nameMm: nameMm,
                barcode: barcode,
                sku: sku,
                cost: cost,
                price: price,
                packSize: packSize,
                packPrice: packPrice,
                buyPrice: buyPrice,
                packBuyPrice: packBuyPrice,
                previousPrice: previousPrice,
                previousPackPrice: previousPackPrice,
                reorderLevel: reorderLevel,
                isActive: isActive,
                deviceId: deviceId,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      required String id,
      required String shopId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String?> phone,
      Value<String?> note,
      Value<String> syncStatus,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String?> phone,
      Value<String?> note,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameMm =>
      $composableBuilder(column: $table.nameMm, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
          Supplier,
          PrefetchHooks Function()
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                shopId: shopId,
                nameEn: nameEn,
                nameMm: nameMm,
                phone: phone,
                note: note,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                shopId: shopId,
                nameEn: nameEn,
                nameMm: nameMm,
                phone: phone,
                note: note,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
      Supplier,
      PrefetchHooks Function()
    >;
typedef $$PurchasesTableCreateCompanionBuilder =
    PurchasesCompanion Function({
      required String id,
      required String shopId,
      required String deviceId,
      Value<String?> supplierId,
      required String staffId,
      required String purchaseNo,
      required DateTime purchasedAt,
      required double total,
      Value<String?> note,
      Value<String> syncStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PurchasesTableUpdateCompanionBuilder =
    PurchasesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> deviceId,
      Value<String?> supplierId,
      Value<String> staffId,
      Value<String> purchaseNo,
      Value<DateTime> purchasedAt,
      Value<double> total,
      Value<String?> note,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PurchasesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseNo => $composableBuilder(
    column: $table.purchaseNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseNo => $composableBuilder(
    column: $table.purchaseNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get purchaseNo => $composableBuilder(
    column: $table.purchaseNo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasesTable,
          Purchase,
          $$PurchasesTableFilterComposer,
          $$PurchasesTableOrderingComposer,
          $$PurchasesTableAnnotationComposer,
          $$PurchasesTableCreateCompanionBuilder,
          $$PurchasesTableUpdateCompanionBuilder,
          (Purchase, BaseReferences<_$AppDatabase, $PurchasesTable, Purchase>),
          Purchase,
          PrefetchHooks Function()
        > {
  $$PurchasesTableTableManager(_$AppDatabase db, $PurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String?> supplierId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<String> purchaseNo = const Value.absent(),
                Value<DateTime> purchasedAt = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchasesCompanion(
                id: id,
                shopId: shopId,
                deviceId: deviceId,
                supplierId: supplierId,
                staffId: staffId,
                purchaseNo: purchaseNo,
                purchasedAt: purchasedAt,
                total: total,
                note: note,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String deviceId,
                Value<String?> supplierId = const Value.absent(),
                required String staffId,
                required String purchaseNo,
                required DateTime purchasedAt,
                required double total,
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PurchasesCompanion.insert(
                id: id,
                shopId: shopId,
                deviceId: deviceId,
                supplierId: supplierId,
                staffId: staffId,
                purchaseNo: purchaseNo,
                purchasedAt: purchasedAt,
                total: total,
                note: note,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasesTable,
      Purchase,
      $$PurchasesTableFilterComposer,
      $$PurchasesTableOrderingComposer,
      $$PurchasesTableAnnotationComposer,
      $$PurchasesTableCreateCompanionBuilder,
      $$PurchasesTableUpdateCompanionBuilder,
      (Purchase, BaseReferences<_$AppDatabase, $PurchasesTable, Purchase>),
      Purchase,
      PrefetchHooks Function()
    >;
typedef $$PurchaseLinesTableCreateCompanionBuilder =
    PurchaseLinesCompanion Function({
      required String id,
      required String purchaseId,
      required String productId,
      required double qty,
      required double unitCost,
      required double lineTotal,
      Value<double> packSize,
      Value<int> rowid,
    });
typedef $$PurchaseLinesTableUpdateCompanionBuilder =
    PurchaseLinesCompanion Function({
      Value<String> id,
      Value<String> purchaseId,
      Value<String> productId,
      Value<double> qty,
      Value<double> unitCost,
      Value<double> lineTotal,
      Value<double> packSize,
      Value<int> rowid,
    });

class $$PurchaseLinesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseLinesTable> {
  $$PurchaseLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lineTotal => $composableBuilder(
    column: $table.lineTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseLinesTable> {
  $$PurchaseLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lineTotal => $composableBuilder(
    column: $table.lineTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseLinesTable> {
  $$PurchaseLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<double> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  GeneratedColumn<double> get lineTotal =>
      $composableBuilder(column: $table.lineTotal, builder: (column) => column);

  GeneratedColumn<double> get packSize =>
      $composableBuilder(column: $table.packSize, builder: (column) => column);
}

class $$PurchaseLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseLinesTable,
          PurchaseLine,
          $$PurchaseLinesTableFilterComposer,
          $$PurchaseLinesTableOrderingComposer,
          $$PurchaseLinesTableAnnotationComposer,
          $$PurchaseLinesTableCreateCompanionBuilder,
          $$PurchaseLinesTableUpdateCompanionBuilder,
          (
            PurchaseLine,
            BaseReferences<_$AppDatabase, $PurchaseLinesTable, PurchaseLine>,
          ),
          PurchaseLine,
          PrefetchHooks Function()
        > {
  $$PurchaseLinesTableTableManager(_$AppDatabase db, $PurchaseLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> purchaseId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<double> qty = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<double> lineTotal = const Value.absent(),
                Value<double> packSize = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseLinesCompanion(
                id: id,
                purchaseId: purchaseId,
                productId: productId,
                qty: qty,
                unitCost: unitCost,
                lineTotal: lineTotal,
                packSize: packSize,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String purchaseId,
                required String productId,
                required double qty,
                required double unitCost,
                required double lineTotal,
                Value<double> packSize = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseLinesCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                productId: productId,
                qty: qty,
                unitCost: unitCost,
                lineTotal: lineTotal,
                packSize: packSize,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseLinesTable,
      PurchaseLine,
      $$PurchaseLinesTableFilterComposer,
      $$PurchaseLinesTableOrderingComposer,
      $$PurchaseLinesTableAnnotationComposer,
      $$PurchaseLinesTableCreateCompanionBuilder,
      $$PurchaseLinesTableUpdateCompanionBuilder,
      (
        PurchaseLine,
        BaseReferences<_$AppDatabase, $PurchaseLinesTable, PurchaseLine>,
      ),
      PurchaseLine,
      PrefetchHooks Function()
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      required String id,
      required String shopId,
      required String deviceId,
      required String staffId,
      required String saleNo,
      required DateTime soldAt,
      required double subtotal,
      Value<double> discount,
      required double total,
      required double paidAmount,
      required String paymentMethod,
      Value<String> syncStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> deviceId,
      Value<String> staffId,
      Value<String> saleNo,
      Value<DateTime> soldAt,
      Value<double> subtotal,
      Value<double> discount,
      Value<double> total,
      Value<double> paidAmount,
      Value<String> paymentMethod,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get saleNo => $composableBuilder(
    column: $table.saleNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get soldAt => $composableBuilder(
    column: $table.soldAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get saleNo => $composableBuilder(
    column: $table.saleNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get soldAt => $composableBuilder(
    column: $table.soldAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get saleNo =>
      $composableBuilder(column: $table.saleNo, builder: (column) => column);

  GeneratedColumn<DateTime> get soldAt =>
      $composableBuilder(column: $table.soldAt, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
          Sale,
          PrefetchHooks Function()
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<String> saleNo = const Value.absent(),
                Value<DateTime> soldAt = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                shopId: shopId,
                deviceId: deviceId,
                staffId: staffId,
                saleNo: saleNo,
                soldAt: soldAt,
                subtotal: subtotal,
                discount: discount,
                total: total,
                paidAmount: paidAmount,
                paymentMethod: paymentMethod,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String deviceId,
                required String staffId,
                required String saleNo,
                required DateTime soldAt,
                required double subtotal,
                Value<double> discount = const Value.absent(),
                required double total,
                required double paidAmount,
                required String paymentMethod,
                Value<String> syncStatus = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                shopId: shopId,
                deviceId: deviceId,
                staffId: staffId,
                saleNo: saleNo,
                soldAt: soldAt,
                subtotal: subtotal,
                discount: discount,
                total: total,
                paidAmount: paidAmount,
                paymentMethod: paymentMethod,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
      Sale,
      PrefetchHooks Function()
    >;
typedef $$SaleLinesTableCreateCompanionBuilder =
    SaleLinesCompanion Function({
      required String id,
      required String saleId,
      required String productId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      required double qty,
      required double unitPrice,
      required double unitCost,
      required double lineTotal,
      required double lineCost,
      Value<double> packSize,
      Value<int> rowid,
    });
typedef $$SaleLinesTableUpdateCompanionBuilder =
    SaleLinesCompanion Function({
      Value<String> id,
      Value<String> saleId,
      Value<String> productId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<double> qty,
      Value<double> unitPrice,
      Value<double> unitCost,
      Value<double> lineTotal,
      Value<double> lineCost,
      Value<double> packSize,
      Value<int> rowid,
    });

class $$SaleLinesTableFilterComposer
    extends Composer<_$AppDatabase, $SaleLinesTable> {
  $$SaleLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get saleId => $composableBuilder(
    column: $table.saleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lineTotal => $composableBuilder(
    column: $table.lineTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lineCost => $composableBuilder(
    column: $table.lineCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SaleLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleLinesTable> {
  $$SaleLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get saleId => $composableBuilder(
    column: $table.saleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lineTotal => $composableBuilder(
    column: $table.lineTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lineCost => $composableBuilder(
    column: $table.lineCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SaleLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleLinesTable> {
  $$SaleLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get saleId =>
      $composableBuilder(column: $table.saleId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameMm =>
      $composableBuilder(column: $table.nameMm, builder: (column) => column);

  GeneratedColumn<double> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  GeneratedColumn<double> get lineTotal =>
      $composableBuilder(column: $table.lineTotal, builder: (column) => column);

  GeneratedColumn<double> get lineCost =>
      $composableBuilder(column: $table.lineCost, builder: (column) => column);

  GeneratedColumn<double> get packSize =>
      $composableBuilder(column: $table.packSize, builder: (column) => column);
}

class $$SaleLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleLinesTable,
          SaleLine,
          $$SaleLinesTableFilterComposer,
          $$SaleLinesTableOrderingComposer,
          $$SaleLinesTableAnnotationComposer,
          $$SaleLinesTableCreateCompanionBuilder,
          $$SaleLinesTableUpdateCompanionBuilder,
          (SaleLine, BaseReferences<_$AppDatabase, $SaleLinesTable, SaleLine>),
          SaleLine,
          PrefetchHooks Function()
        > {
  $$SaleLinesTableTableManager(_$AppDatabase db, $SaleLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> saleId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<double> qty = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<double> lineTotal = const Value.absent(),
                Value<double> lineCost = const Value.absent(),
                Value<double> packSize = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleLinesCompanion(
                id: id,
                saleId: saleId,
                productId: productId,
                nameEn: nameEn,
                nameMm: nameMm,
                qty: qty,
                unitPrice: unitPrice,
                unitCost: unitCost,
                lineTotal: lineTotal,
                lineCost: lineCost,
                packSize: packSize,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String saleId,
                required String productId,
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                required double qty,
                required double unitPrice,
                required double unitCost,
                required double lineTotal,
                required double lineCost,
                Value<double> packSize = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleLinesCompanion.insert(
                id: id,
                saleId: saleId,
                productId: productId,
                nameEn: nameEn,
                nameMm: nameMm,
                qty: qty,
                unitPrice: unitPrice,
                unitCost: unitCost,
                lineTotal: lineTotal,
                lineCost: lineCost,
                packSize: packSize,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SaleLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleLinesTable,
      SaleLine,
      $$SaleLinesTableFilterComposer,
      $$SaleLinesTableOrderingComposer,
      $$SaleLinesTableAnnotationComposer,
      $$SaleLinesTableCreateCompanionBuilder,
      $$SaleLinesTableUpdateCompanionBuilder,
      (SaleLine, BaseReferences<_$AppDatabase, $SaleLinesTable, SaleLine>),
      SaleLine,
      PrefetchHooks Function()
    >;
typedef $$DamagesTableCreateCompanionBuilder =
    DamagesCompanion Function({
      required String id,
      required String shopId,
      required String deviceId,
      required String staffId,
      required String damageNo,
      required DateTime damagedAt,
      Value<String?> note,
      Value<String> syncStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DamagesTableUpdateCompanionBuilder =
    DamagesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> deviceId,
      Value<String> staffId,
      Value<String> damageNo,
      Value<DateTime> damagedAt,
      Value<String?> note,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DamagesTableFilterComposer
    extends Composer<_$AppDatabase, $DamagesTable> {
  $$DamagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageNo => $composableBuilder(
    column: $table.damageNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get damagedAt => $composableBuilder(
    column: $table.damagedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DamagesTableOrderingComposer
    extends Composer<_$AppDatabase, $DamagesTable> {
  $$DamagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageNo => $composableBuilder(
    column: $table.damageNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get damagedAt => $composableBuilder(
    column: $table.damagedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DamagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DamagesTable> {
  $$DamagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get damageNo =>
      $composableBuilder(column: $table.damageNo, builder: (column) => column);

  GeneratedColumn<DateTime> get damagedAt =>
      $composableBuilder(column: $table.damagedAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DamagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DamagesTable,
          Damage,
          $$DamagesTableFilterComposer,
          $$DamagesTableOrderingComposer,
          $$DamagesTableAnnotationComposer,
          $$DamagesTableCreateCompanionBuilder,
          $$DamagesTableUpdateCompanionBuilder,
          (Damage, BaseReferences<_$AppDatabase, $DamagesTable, Damage>),
          Damage,
          PrefetchHooks Function()
        > {
  $$DamagesTableTableManager(_$AppDatabase db, $DamagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DamagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DamagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DamagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<String> damageNo = const Value.absent(),
                Value<DateTime> damagedAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DamagesCompanion(
                id: id,
                shopId: shopId,
                deviceId: deviceId,
                staffId: staffId,
                damageNo: damageNo,
                damagedAt: damagedAt,
                note: note,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String deviceId,
                required String staffId,
                required String damageNo,
                required DateTime damagedAt,
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DamagesCompanion.insert(
                id: id,
                shopId: shopId,
                deviceId: deviceId,
                staffId: staffId,
                damageNo: damageNo,
                damagedAt: damagedAt,
                note: note,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DamagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DamagesTable,
      Damage,
      $$DamagesTableFilterComposer,
      $$DamagesTableOrderingComposer,
      $$DamagesTableAnnotationComposer,
      $$DamagesTableCreateCompanionBuilder,
      $$DamagesTableUpdateCompanionBuilder,
      (Damage, BaseReferences<_$AppDatabase, $DamagesTable, Damage>),
      Damage,
      PrefetchHooks Function()
    >;
typedef $$DamageLinesTableCreateCompanionBuilder =
    DamageLinesCompanion Function({
      required String id,
      required String damageId,
      required String productId,
      required double qty,
      required double unitCost,
      required double lineCost,
      required String reason,
      Value<int> rowid,
    });
typedef $$DamageLinesTableUpdateCompanionBuilder =
    DamageLinesCompanion Function({
      Value<String> id,
      Value<String> damageId,
      Value<String> productId,
      Value<double> qty,
      Value<double> unitCost,
      Value<double> lineCost,
      Value<String> reason,
      Value<int> rowid,
    });

class $$DamageLinesTableFilterComposer
    extends Composer<_$AppDatabase, $DamageLinesTable> {
  $$DamageLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageId => $composableBuilder(
    column: $table.damageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lineCost => $composableBuilder(
    column: $table.lineCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DamageLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $DamageLinesTable> {
  $$DamageLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageId => $composableBuilder(
    column: $table.damageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lineCost => $composableBuilder(
    column: $table.lineCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DamageLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DamageLinesTable> {
  $$DamageLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get damageId =>
      $composableBuilder(column: $table.damageId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<double> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  GeneratedColumn<double> get lineCost =>
      $composableBuilder(column: $table.lineCost, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);
}

class $$DamageLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DamageLinesTable,
          DamageLine,
          $$DamageLinesTableFilterComposer,
          $$DamageLinesTableOrderingComposer,
          $$DamageLinesTableAnnotationComposer,
          $$DamageLinesTableCreateCompanionBuilder,
          $$DamageLinesTableUpdateCompanionBuilder,
          (
            DamageLine,
            BaseReferences<_$AppDatabase, $DamageLinesTable, DamageLine>,
          ),
          DamageLine,
          PrefetchHooks Function()
        > {
  $$DamageLinesTableTableManager(_$AppDatabase db, $DamageLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DamageLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DamageLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DamageLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> damageId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<double> qty = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<double> lineCost = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DamageLinesCompanion(
                id: id,
                damageId: damageId,
                productId: productId,
                qty: qty,
                unitCost: unitCost,
                lineCost: lineCost,
                reason: reason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String damageId,
                required String productId,
                required double qty,
                required double unitCost,
                required double lineCost,
                required String reason,
                Value<int> rowid = const Value.absent(),
              }) => DamageLinesCompanion.insert(
                id: id,
                damageId: damageId,
                productId: productId,
                qty: qty,
                unitCost: unitCost,
                lineCost: lineCost,
                reason: reason,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DamageLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DamageLinesTable,
      DamageLine,
      $$DamageLinesTableFilterComposer,
      $$DamageLinesTableOrderingComposer,
      $$DamageLinesTableAnnotationComposer,
      $$DamageLinesTableCreateCompanionBuilder,
      $$DamageLinesTableUpdateCompanionBuilder,
      (
        DamageLine,
        BaseReferences<_$AppDatabase, $DamageLinesTable, DamageLine>,
      ),
      DamageLine,
      PrefetchHooks Function()
    >;
typedef $$ExpenseCategoriesTableCreateCompanionBuilder =
    ExpenseCategoriesCompanion Function({
      required String id,
      required String shopId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String> syncStatus,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ExpenseCategoriesTableUpdateCompanionBuilder =
    ExpenseCategoriesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String?> nameEn,
      Value<String?> nameMm,
      Value<String> syncStatus,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ExpenseCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameMm => $composableBuilder(
    column: $table.nameMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameMm =>
      $composableBuilder(column: $table.nameMm, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExpenseCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseCategoriesTable,
          ExpenseCategory,
          $$ExpenseCategoriesTableFilterComposer,
          $$ExpenseCategoriesTableOrderingComposer,
          $$ExpenseCategoriesTableAnnotationComposer,
          $$ExpenseCategoriesTableCreateCompanionBuilder,
          $$ExpenseCategoriesTableUpdateCompanionBuilder,
          (
            ExpenseCategory,
            BaseReferences<
              _$AppDatabase,
              $ExpenseCategoriesTable,
              ExpenseCategory
            >,
          ),
          ExpenseCategory,
          PrefetchHooks Function()
        > {
  $$ExpenseCategoriesTableTableManager(
    _$AppDatabase db,
    $ExpenseCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpenseCategoriesCompanion(
                id: id,
                shopId: shopId,
                nameEn: nameEn,
                nameMm: nameMm,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                Value<String?> nameEn = const Value.absent(),
                Value<String?> nameMm = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ExpenseCategoriesCompanion.insert(
                id: id,
                shopId: shopId,
                nameEn: nameEn,
                nameMm: nameMm,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseCategoriesTable,
      ExpenseCategory,
      $$ExpenseCategoriesTableFilterComposer,
      $$ExpenseCategoriesTableOrderingComposer,
      $$ExpenseCategoriesTableAnnotationComposer,
      $$ExpenseCategoriesTableCreateCompanionBuilder,
      $$ExpenseCategoriesTableUpdateCompanionBuilder,
      (
        ExpenseCategory,
        BaseReferences<_$AppDatabase, $ExpenseCategoriesTable, ExpenseCategory>,
      ),
      ExpenseCategory,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      required String id,
      required String shopId,
      required String deviceId,
      required String staffId,
      required String expenseCategoryId,
      required String title,
      required double amount,
      required DateTime spentAt,
      Value<String?> note,
      Value<String> syncStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> deviceId,
      Value<String> staffId,
      Value<String> expenseCategoryId,
      Value<String> title,
      Value<double> amount,
      Value<DateTime> spentAt,
      Value<String?> note,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expenseCategoryId => $composableBuilder(
    column: $table.expenseCategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get spentAt => $composableBuilder(
    column: $table.spentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expenseCategoryId => $composableBuilder(
    column: $table.expenseCategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get spentAt => $composableBuilder(
    column: $table.spentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get expenseCategoryId => $composableBuilder(
    column: $table.expenseCategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get spentAt =>
      $composableBuilder(column: $table.spentAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<String> expenseCategoryId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> spentAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                shopId: shopId,
                deviceId: deviceId,
                staffId: staffId,
                expenseCategoryId: expenseCategoryId,
                title: title,
                amount: amount,
                spentAt: spentAt,
                note: note,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String deviceId,
                required String staffId,
                required String expenseCategoryId,
                required String title,
                required double amount,
                required DateTime spentAt,
                Value<String?> note = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                shopId: shopId,
                deviceId: deviceId,
                staffId: staffId,
                expenseCategoryId: expenseCategoryId,
                title: title,
                amount: amount,
                spentAt: spentAt,
                note: note,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$RepurchasesTableCreateCompanionBuilder =
    RepurchasesCompanion Function({
      required String id,
      required String shopId,
      required String repurchaseNo,
      Value<String> status,
      Value<String?> purchaseId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$RepurchasesTableUpdateCompanionBuilder =
    RepurchasesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> repurchaseNo,
      Value<String> status,
      Value<String?> purchaseId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$RepurchasesTableFilterComposer
    extends Composer<_$AppDatabase, $RepurchasesTable> {
  $$RepurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repurchaseNo => $composableBuilder(
    column: $table.repurchaseNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RepurchasesTableOrderingComposer
    extends Composer<_$AppDatabase, $RepurchasesTable> {
  $$RepurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repurchaseNo => $composableBuilder(
    column: $table.repurchaseNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RepurchasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepurchasesTable> {
  $$RepurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get repurchaseNo => $composableBuilder(
    column: $table.repurchaseNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RepurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepurchasesTable,
          Repurchase,
          $$RepurchasesTableFilterComposer,
          $$RepurchasesTableOrderingComposer,
          $$RepurchasesTableAnnotationComposer,
          $$RepurchasesTableCreateCompanionBuilder,
          $$RepurchasesTableUpdateCompanionBuilder,
          (
            Repurchase,
            BaseReferences<_$AppDatabase, $RepurchasesTable, Repurchase>,
          ),
          Repurchase,
          PrefetchHooks Function()
        > {
  $$RepurchasesTableTableManager(_$AppDatabase db, $RepurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> repurchaseNo = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> purchaseId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepurchasesCompanion(
                id: id,
                shopId: shopId,
                repurchaseNo: repurchaseNo,
                status: status,
                purchaseId: purchaseId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String repurchaseNo,
                Value<String> status = const Value.absent(),
                Value<String?> purchaseId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RepurchasesCompanion.insert(
                id: id,
                shopId: shopId,
                repurchaseNo: repurchaseNo,
                status: status,
                purchaseId: purchaseId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RepurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepurchasesTable,
      Repurchase,
      $$RepurchasesTableFilterComposer,
      $$RepurchasesTableOrderingComposer,
      $$RepurchasesTableAnnotationComposer,
      $$RepurchasesTableCreateCompanionBuilder,
      $$RepurchasesTableUpdateCompanionBuilder,
      (
        Repurchase,
        BaseReferences<_$AppDatabase, $RepurchasesTable, Repurchase>,
      ),
      Repurchase,
      PrefetchHooks Function()
    >;
typedef $$RepurchaseItemsTableCreateCompanionBuilder =
    RepurchaseItemsCompanion Function({
      required String id,
      required String shopId,
      Value<String> repurchaseId,
      required String productId,
      Value<double> qty,
      Value<double> packQty,
      Value<double> packSize,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RepurchaseItemsTableUpdateCompanionBuilder =
    RepurchaseItemsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> repurchaseId,
      Value<String> productId,
      Value<double> qty,
      Value<double> packQty,
      Value<double> packSize,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$RepurchaseItemsTableFilterComposer
    extends Composer<_$AppDatabase, $RepurchaseItemsTable> {
  $$RepurchaseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repurchaseId => $composableBuilder(
    column: $table.repurchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packQty => $composableBuilder(
    column: $table.packQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RepurchaseItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepurchaseItemsTable> {
  $$RepurchaseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repurchaseId => $composableBuilder(
    column: $table.repurchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packQty => $composableBuilder(
    column: $table.packQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RepurchaseItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepurchaseItemsTable> {
  $$RepurchaseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get repurchaseId => $composableBuilder(
    column: $table.repurchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<double> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<double> get packQty =>
      $composableBuilder(column: $table.packQty, builder: (column) => column);

  GeneratedColumn<double> get packSize =>
      $composableBuilder(column: $table.packSize, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RepurchaseItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepurchaseItemsTable,
          RepurchaseItem,
          $$RepurchaseItemsTableFilterComposer,
          $$RepurchaseItemsTableOrderingComposer,
          $$RepurchaseItemsTableAnnotationComposer,
          $$RepurchaseItemsTableCreateCompanionBuilder,
          $$RepurchaseItemsTableUpdateCompanionBuilder,
          (
            RepurchaseItem,
            BaseReferences<
              _$AppDatabase,
              $RepurchaseItemsTable,
              RepurchaseItem
            >,
          ),
          RepurchaseItem,
          PrefetchHooks Function()
        > {
  $$RepurchaseItemsTableTableManager(
    _$AppDatabase db,
    $RepurchaseItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepurchaseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepurchaseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepurchaseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> repurchaseId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<double> qty = const Value.absent(),
                Value<double> packQty = const Value.absent(),
                Value<double> packSize = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepurchaseItemsCompanion(
                id: id,
                shopId: shopId,
                repurchaseId: repurchaseId,
                productId: productId,
                qty: qty,
                packQty: packQty,
                packSize: packSize,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                Value<String> repurchaseId = const Value.absent(),
                required String productId,
                Value<double> qty = const Value.absent(),
                Value<double> packQty = const Value.absent(),
                Value<double> packSize = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RepurchaseItemsCompanion.insert(
                id: id,
                shopId: shopId,
                repurchaseId: repurchaseId,
                productId: productId,
                qty: qty,
                packQty: packQty,
                packSize: packSize,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RepurchaseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepurchaseItemsTable,
      RepurchaseItem,
      $$RepurchaseItemsTableFilterComposer,
      $$RepurchaseItemsTableOrderingComposer,
      $$RepurchaseItemsTableAnnotationComposer,
      $$RepurchaseItemsTableCreateCompanionBuilder,
      $$RepurchaseItemsTableUpdateCompanionBuilder,
      (
        RepurchaseItem,
        BaseReferences<_$AppDatabase, $RepurchaseItemsTable, RepurchaseItem>,
      ),
      RepurchaseItem,
      PrefetchHooks Function()
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      required String id,
      required String shopId,
      required String productId,
      required String sourceType,
      required String sourceId,
      required double qtyChange,
      required double unitCost,
      required DateTime happenedAt,
      Value<int> rowid,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> productId,
      Value<String> sourceType,
      Value<String> sourceId,
      Value<double> qtyChange,
      Value<double> unitCost,
      Value<DateTime> happenedAt,
      Value<int> rowid,
    });

class $$StockMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qtyChange => $composableBuilder(
    column: $table.qtyChange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get happenedAt => $composableBuilder(
    column: $table.happenedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qtyChange => $composableBuilder(
    column: $table.qtyChange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get happenedAt => $composableBuilder(
    column: $table.happenedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<double> get qtyChange =>
      $composableBuilder(column: $table.qtyChange, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  GeneratedColumn<DateTime> get happenedAt => $composableBuilder(
    column: $table.happenedAt,
    builder: (column) => column,
  );
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTable,
          StockMovement,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (
            StockMovement,
            BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement>,
          ),
          StockMovement,
          PrefetchHooks Function()
        > {
  $$StockMovementsTableTableManager(
    _$AppDatabase db,
    $StockMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<double> qtyChange = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<DateTime> happenedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsCompanion(
                id: id,
                shopId: shopId,
                productId: productId,
                sourceType: sourceType,
                sourceId: sourceId,
                qtyChange: qtyChange,
                unitCost: unitCost,
                happenedAt: happenedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String productId,
                required String sourceType,
                required String sourceId,
                required double qtyChange,
                required double unitCost,
                required DateTime happenedAt,
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsCompanion.insert(
                id: id,
                shopId: shopId,
                productId: productId,
                sourceType: sourceType,
                sourceId: sourceId,
                qtyChange: qtyChange,
                unitCost: unitCost,
                happenedAt: happenedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTable,
      StockMovement,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (
        StockMovement,
        BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement>,
      ),
      StockMovement,
      PrefetchHooks Function()
    >;
typedef $$DeveloperReportsTableCreateCompanionBuilder =
    DeveloperReportsCompanion Function({
      required String id,
      required String message,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$DeveloperReportsTableUpdateCompanionBuilder =
    DeveloperReportsCompanion Function({
      Value<String> id,
      Value<String> message,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$DeveloperReportsTableFilterComposer
    extends Composer<_$AppDatabase, $DeveloperReportsTable> {
  $$DeveloperReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeveloperReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeveloperReportsTable> {
  $$DeveloperReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeveloperReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeveloperReportsTable> {
  $$DeveloperReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DeveloperReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeveloperReportsTable,
          DeveloperReport,
          $$DeveloperReportsTableFilterComposer,
          $$DeveloperReportsTableOrderingComposer,
          $$DeveloperReportsTableAnnotationComposer,
          $$DeveloperReportsTableCreateCompanionBuilder,
          $$DeveloperReportsTableUpdateCompanionBuilder,
          (
            DeveloperReport,
            BaseReferences<
              _$AppDatabase,
              $DeveloperReportsTable,
              DeveloperReport
            >,
          ),
          DeveloperReport,
          PrefetchHooks Function()
        > {
  $$DeveloperReportsTableTableManager(
    _$AppDatabase db,
    $DeveloperReportsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeveloperReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeveloperReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeveloperReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeveloperReportsCompanion(
                id: id,
                message: message,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String message,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DeveloperReportsCompanion.insert(
                id: id,
                message: message,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeveloperReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeveloperReportsTable,
      DeveloperReport,
      $$DeveloperReportsTableFilterComposer,
      $$DeveloperReportsTableOrderingComposer,
      $$DeveloperReportsTableAnnotationComposer,
      $$DeveloperReportsTableCreateCompanionBuilder,
      $$DeveloperReportsTableUpdateCompanionBuilder,
      (
        DeveloperReport,
        BaseReferences<_$AppDatabase, $DeveloperReportsTable, DeveloperReport>,
      ),
      DeveloperReport,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ShopsTableTableManager get shops =>
      $$ShopsTableTableManager(_db, _db.shops);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
  $$StaffTableTableManager get staff =>
      $$StaffTableTableManager(_db, _db.staff);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$UnitsTableTableManager get units =>
      $$UnitsTableTableManager(_db, _db.units);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db, _db.purchases);
  $$PurchaseLinesTableTableManager get purchaseLines =>
      $$PurchaseLinesTableTableManager(_db, _db.purchaseLines);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleLinesTableTableManager get saleLines =>
      $$SaleLinesTableTableManager(_db, _db.saleLines);
  $$DamagesTableTableManager get damages =>
      $$DamagesTableTableManager(_db, _db.damages);
  $$DamageLinesTableTableManager get damageLines =>
      $$DamageLinesTableTableManager(_db, _db.damageLines);
  $$ExpenseCategoriesTableTableManager get expenseCategories =>
      $$ExpenseCategoriesTableTableManager(_db, _db.expenseCategories);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$RepurchasesTableTableManager get repurchases =>
      $$RepurchasesTableTableManager(_db, _db.repurchases);
  $$RepurchaseItemsTableTableManager get repurchaseItems =>
      $$RepurchaseItemsTableTableManager(_db, _db.repurchaseItems);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$DeveloperReportsTableTableManager get developerReports =>
      $$DeveloperReportsTableTableManager(_db, _db.developerReports);
}
