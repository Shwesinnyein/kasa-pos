import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/copy.dart';
import '../../../app/theme.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../auth/domain/entities/staff_user.dart';
import '../../session/session_controller.dart';
import '../data/account_local_data_source.dart';

class AccountListScreen extends ConsumerWidget {
  const AccountListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copy = AppCopy(english: ref.watch(settingsProvider).value?.english ?? false);
    final accounts = ref.watch(accountListProvider);
    final me = ref.watch(sessionProvider)?.id;
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: accounts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(copy.saveFailed)),
        data: (items) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  Expanded(child: Text(copy.accounts, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
                  FilledButton.icon(
                    onPressed: () => _open(context, null),
                    icon: const Icon(Icons.add),
                    label: Text(copy.add),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(copy.name, style: _header)),
                  Expanded(flex: 2, child: Text(copy.role, style: _header)),
                  Expanded(flex: 2, child: Text(copy.loginAllowed, style: _header)),
                  const SizedBox(width: 150),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Material(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w700))),
                          Expanded(flex: 2, child: Text(item.role == StaffRole.owner ? copy.owner : copy.cashier)),
                          Expanded(flex: 2, child: Text(item.active ? copy.allowed : copy.blocked, style: TextStyle(color: item.active ? KasaColors.online : KasaColors.danger))),
                          TextButton(onPressed: () => _open(context, item), child: Text(copy.edit)),
                          TextButton(
                            onPressed: () => _remove(context, ref, copy, item, me),
                            child: Text(copy.delete, style: const TextStyle(color: KasaColors.danger)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _open(BuildContext context, AccountUser? user) async {
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => AccountFormScreen(user: user)));
  }

  Future<void> _remove(BuildContext context, WidgetRef ref, AppCopy copy, AccountUser user, String? me) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(copy.deleteUser),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(copy.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(copy.delete)),
        ],
      ),
    );
    if (yes != true || !context.mounted) return;
    final error = await AccountLocalDataSource(ref.read(databaseProvider)).remove(user.id);
    if (!context.mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_message(copy, error))));
      return;
    }
    ref.invalidate(accountListProvider);
    if (user.id == me) ref.read(sessionProvider.notifier).signOut();
  }
}

class AccountFormScreen extends ConsumerStatefulWidget {
  const AccountFormScreen({super.key, this.user});

  final AccountUser? user;

  @override
  ConsumerState<AccountFormScreen> createState() => _AccountFormScreenState();
}

class _AccountFormScreenState extends ConsumerState<AccountFormScreen> {
  late final TextEditingController _name;
  late final TextEditingController _pin;
  late StaffRole _role;
  late bool _active;
  String? _error;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.user?.name ?? '');
    _pin = TextEditingController();
    _role = widget.user?.role ?? StaffRole.cashier;
    _active = widget.user?.active ?? true;
  }

  @override
  void dispose() {
    _name.dispose();
    _pin.dispose();
    super.dispose();
  }

  Future<void> _save(AppCopy copy) async {
    setState(() {
      _saving = true;
      _error = null;
    });
    final raw = _pin.text.trim();
    final digits = raw.split('').map((char) {
      const myanmar = '၀၁၂၃၄၅၆၇၈၉';
      const latin = '0123456789';
      final index = myanmar.indexOf(char);
      return index >= 0 ? latin[index] : char;
    }).join();
    final error = await AccountLocalDataSource(ref.read(databaseProvider)).save(
      id: widget.user?.id,
      name: _name.text,
      role: _role,
      pin: digits,
      active: _active,
    );
    if (!mounted) return;
    if (error != null) {
      setState(() {
        _saving = false;
        _error = _message(copy, error);
      });
      return;
    }
    ref.invalidate(accountListProvider);
    final me = ref.read(sessionProvider);
    if (me != null && me.id == widget.user?.id) {
      if (!_active) {
        ref.read(sessionProvider.notifier).signOut();
      } else {
        ref.read(sessionProvider.notifier).signIn(StaffUser(id: me.id, name: _name.text.trim(), role: _role));
      }
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final copy = AppCopy(english: ref.watch(settingsProvider).value?.english ?? false);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        children: [
          Text(widget.user == null ? copy.newUser : copy.editUser, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          TextField(controller: _name, decoration: InputDecoration(labelText: copy.name, filled: true, fillColor: Theme.of(context).cardColor)),
          const SizedBox(height: 12),
          Text(copy.role),
          const SizedBox(height: 8),
          Row(
            children: [
              _roleChip(copy.owner, StaffRole.owner),
              const SizedBox(width: 8),
              _roleChip(copy.cashier, StaffRole.cashier),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _pin,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉]')), LengthLimitingTextInputFormatter(4)],
            decoration: InputDecoration(labelText: copy.pin, hintText: widget.user == null ? null : copy.pinHint, filled: true, fillColor: Theme.of(context).cardColor),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(copy.loginAllowed),
            value: _active,
            onChanged: (value) => setState(() => _active = value),
          ),
          if (_error != null) Text(_error!, style: const TextStyle(color: KasaColors.danger)),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(onPressed: _saving ? null : () => _save(copy), child: Text(copy.save)),
          ),
        ],
      ),
    );
  }

  Widget _roleChip(String label, StaffRole role) {
    final selected = _role == role;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: KasaColors.brown,
      labelStyle: TextStyle(color: selected ? Colors.white : null),
      onSelected: (_) => setState(() => _role = role),
    );
  }
}

String _message(AppCopy copy, String code) {
  return switch (code) {
    'name' => copy.nameRequired,
    'pin' => copy.pinRequired,
    'pin_used' => copy.pinUsed,
    'owner' => copy.keepOwner,
    _ => copy.saveFailed,
  };
}

const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);
