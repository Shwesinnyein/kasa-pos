class ShopProfile {
  const ShopProfile({required this.id, required this.nameMm, required this.nameEn});

  final String id;
  final String nameMm;
  final String nameEn;

  String get displayName => nameMm.isEmpty ? nameEn : nameMm;
}
