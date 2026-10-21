enum StaffRole { owner, cashier }

class StaffUser {
  const StaffUser({required this.id, required this.name, required this.role});

  final String id;
  final String name;
  final StaffRole role;

  bool get isOwner => role == StaffRole.owner;
}
