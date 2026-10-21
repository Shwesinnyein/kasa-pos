import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/copy.dart';
import '../../../app/theme.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../session/session_controller.dart';
import '../../auth/domain/entities/staff_user.dart';
import '../data/settings_local_data_source.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value ?? AppSettings.fallback;
    final copy = AppCopy(english: settings.english);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        children: [
          Text(copy.settings, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Text(copy.language, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _choice(copy.myanmar, settings.language == 'my', () => _save(ref, settings.copyWith(language: 'my'))),
              _choice('English', settings.language == 'en', () => _save(ref, settings.copyWith(language: 'en'))),
            ],
          ),
          const SizedBox(height: 20),
          Text(copy.themeColor, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final entry in themePalette.entries)
                GestureDetector(
                  onTap: () => _save(ref, settings.copyWith(themeColor: entry.key)),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: entry.value,
                      shape: BoxShape.circle,
                      border: Border.all(color: settings.themeColor == entry.key ? Colors.white : Colors.transparent, width: 3),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(copy.appearance, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _choice(copy.light, settings.themeMode == 'light', () => _save(ref, settings.copyWith(themeMode: 'light'))),
              _choice(copy.system, settings.themeMode == 'system', () => _save(ref, settings.copyWith(themeMode: 'system'))),
              _choice(copy.dark, settings.themeMode == 'dark', () => _save(ref, settings.copyWith(themeMode: 'dark'))),
            ],
          ),
          const SizedBox(height: 20),
          _tile(context, copy.policy, () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const PolicyScreen()))),
          _tile(context, copy.report, () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const ReportScreen()))),
          _tile(context, copy.profile, () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const ProfileScreen()))),
          _tile(context, copy.shopName, () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const ShopNameScreen()))),
          _tile(context, copy.cloud, () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const CloudSyncScreen()))),
        ],
      ),
    );
  }

  Future<void> _save(WidgetRef ref, AppSettings settings) {
    return ref.read(settingsProvider.notifier).save(settings);
  }

  Widget _choice(String label, bool selected, VoidCallback onTap) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: KasaColors.brown,
      labelStyle: TextStyle(color: selected ? Colors.white : null),
      onSelected: (_) => onTap(),
    );
  }

  Widget _tile(BuildContext context, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        child: ListTile(
          title: Text(label),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}

class PolicyScreen extends ConsumerWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copy = AppCopy(english: ref.watch(settingsProvider).value?.english ?? false);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(copy.policy, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text(copy.policyBody, style: const TextStyle(fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }
}

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  final _message = TextEditingController();
  var _notes = const <DeveloperNote>[];
  var _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final notes = await SettingsLocalDataSource(ref.read(databaseProvider)).reports();
    if (!mounted) return;
    setState(() {
      _notes = notes;
      _loading = false;
    });
  }

  Future<void> _send() async {
    final text = _message.text.trim();
    if (text.isEmpty) return;
    await SettingsLocalDataSource(ref.read(databaseProvider)).addReport(text);
    _message.clear();
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final copy = AppCopy(english: ref.watch(settingsProvider).value?.english ?? false);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(copy.report, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          TextField(
            controller: _message,
            minLines: 3,
            maxLines: 6,
            decoration: InputDecoration(hintText: copy.reportHint, filled: true, fillColor: Theme.of(context).cardColor),
          ),
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerRight, child: FilledButton(onPressed: _send, child: Text(copy.save))),
          const SizedBox(height: 8),
          Text(copy.reportSaved, style: const TextStyle(color: KasaColors.muted)),
          const SizedBox(height: 16),
          if (_loading) const LinearProgressIndicator(),
          if (!_loading && _notes.isEmpty) Text(copy.noReports, style: const TextStyle(color: KasaColors.muted)),
          for (final note in _notes)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}', style: const TextStyle(color: KasaColors.muted, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(note.message),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final TextEditingController _name;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: ref.read(sessionProvider)?.name ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final staff = ref.read(sessionProvider);
    final name = _name.text.trim();
    if (staff == null || name.isEmpty) return;
    setState(() => _saving = true);
    await SettingsLocalDataSource(ref.read(databaseProvider)).renameStaff(staff.id, name);
    ref.read(sessionProvider.notifier).signIn(StaffUser(id: staff.id, name: name, role: staff.role));
    ref.invalidate(accountListProvider);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final copy = AppCopy(english: ref.watch(settingsProvider).value?.english ?? false);
    final staff = ref.watch(sessionProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(copy.profile, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(staff?.isOwner == true ? copy.owner : copy.cashier, style: const TextStyle(color: KasaColors.muted)),
          const SizedBox(height: 16),
          TextField(controller: _name, decoration: InputDecoration(labelText: copy.name, filled: true, fillColor: Theme.of(context).cardColor)),
          const SizedBox(height: 16),
          Align(alignment: Alignment.centerRight, child: FilledButton(onPressed: _saving ? null : _save, child: Text(copy.save))),
        ],
      ),
    );
  }
}

class ShopNameScreen extends ConsumerStatefulWidget {
  const ShopNameScreen({super.key});

  @override
  ConsumerState<ShopNameScreen> createState() => _ShopNameScreenState();
}

class _ShopNameScreenState extends ConsumerState<ShopNameScreen> {
  late final TextEditingController _name;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: ref.read(shopProfileProvider).value?.nameMm ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    setState(() => _saving = true);
    await SettingsLocalDataSource(ref.read(databaseProvider)).renameShop(name);
    ref.invalidate(shopProfileProvider);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final copy = AppCopy(english: ref.watch(settingsProvider).value?.english ?? false);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(copy.shopName, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(copy.shopHint, style: const TextStyle(color: KasaColors.muted)),
          const SizedBox(height: 16),
          TextField(controller: _name, decoration: InputDecoration(labelText: copy.shopName, filled: true, fillColor: Theme.of(context).cardColor)),
          const SizedBox(height: 16),
          Align(alignment: Alignment.centerRight, child: FilledButton(onPressed: _saving ? null : _save, child: Text(copy.save))),
        ],
      ),
    );
  }
}

class CloudSyncScreen extends ConsumerStatefulWidget {
  const CloudSyncScreen({super.key});

  @override
  ConsumerState<CloudSyncScreen> createState() => _CloudSyncScreenState();
}

class _CloudSyncScreenState extends ConsumerState<CloudSyncScreen> {
  var _busy = false;
  String? _message;

  Future<void> _sync() async {
    final copy = AppCopy(english: ref.read(settingsProvider).value?.english ?? false);
    final online = ref.read(onlineProvider).value == true;
    if (!online) {
      setState(() => _message = copy.cloudOffline);
      return;
    }
    setState(() {
      _busy = true;
      _message = null;
    });
    final error = await ref.read(cloudSyncProvider).push();
    if (!mounted) return;
    setState(() {
      _busy = false;
      _message = switch (error) {
        null => copy.cloudSent,
        'missing' => copy.cloudMissing,
        'url' => copy.cloudBadUrl,
        'secret' => copy.cloudSecret,
        _ => error,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final copy = AppCopy(english: ref.watch(settingsProvider).value?.english ?? false);
    final pending = ref.watch(pendingCountProvider).value ?? 0;
    final online = ref.watch(onlineProvider).value ?? false;
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(copy.cloud, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(copy.cloudHint, style: const TextStyle(color: KasaColors.muted)),
          const SizedBox(height: 20),
          Text(pending == 0 ? copy.cloudNone : '${copy.cloudWaiting} $pending', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(online ? 'အွန်လိုင်း' : copy.cloudOffline, style: TextStyle(color: online ? KasaColors.online : KasaColors.danger)),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(onPressed: _busy ? null : _sync, child: Text(copy.cloudSend)),
          ),
          if (_message != null) ...[
            const SizedBox(height: 12),
            Text(_message!),
          ],
        ],
      ),
    );
  }
}
