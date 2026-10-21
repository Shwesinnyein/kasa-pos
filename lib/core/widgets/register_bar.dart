import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../features/session/session_controller.dart';

class RegisterBar extends ConsumerWidget implements PreferredSizeWidget {
  const RegisterBar({super.key, this.showGear = false});

  final bool showGear;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shop = ref.watch(shopProfileProvider).value;
    final staff = ref.watch(sessionProvider);
    final online = ref.watch(onlineProvider).value ?? false;
    final pending = ref.watch(pendingCountProvider).value ?? 0;

    return AppBar(
      titleSpacing: 16,
      title: Row(
        children: [
          const Icon(Icons.storefront_outlined, size: 22),
          const SizedBox(width: 8),
          Text(shop?.displayName ?? 'Kasa Shop', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          const Spacer(),
          if (staff != null) ...[
            _StaffChip(name: staff.name),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () => ref.read(sessionProvider.notifier).signOut(),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              icon: const Icon(Icons.logout, size: 16),
              label: const Text('ထွက်မည်'),
            ),
          ],
          const SizedBox(width: 12),
          _Status(online: online),
          const SizedBox(width: 12),
          _Pending(count: pending, online: online),
          if (showGear) ...[
            const SizedBox(width: 4),
            IconButton(
              tooltip: 'ဆက်တင်',
              onPressed: () => Navigator.of(context).pushNamed('/settings'),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ],
      ),
    );
  }
}

class _StaffChip extends ConsumerWidget {
  const _StaffChip({required this.name});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      tooltip: name,
      onSelected: (value) {
        if (value == 'out') ref.read(sessionProvider.notifier).signOut();
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'out', child: Text('ထွက်မည်')),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_outline, size: 18),
          const SizedBox(width: 4),
          Text(name, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({required this.online});

  final bool online;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: online ? KasaColors.online : KasaColors.danger, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(online ? 'အွန်လိုင်း' : 'အော့ဖ်လိုင်း', style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class _Pending extends ConsumerWidget {
  const _Pending({required this.count, required this.online});

  final int count;
  final bool online;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'ဒေတာချိတ်မည်',
      onPressed: () => _sync(context, ref),
      icon: Badge(
        isLabelVisible: count > 0,
        label: Text('$count'),
        child: const Icon(Icons.cloud_outlined),
      ),
    );
  }

  Future<void> _sync(BuildContext context, WidgetRef ref) async {
    if (!online) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('အော့ဖ်လိုင်း။ ပို့ရန် $count ခု')));
      return;
    }
    final error = await ref.read(cloudSyncProvider).push();
    if (!context.mounted) return;
    final message = switch (error) {
      null => 'ပို့ပြီးပါပြီ။',
      'missing' => 'လိပ်စာနှင့် key ကို တစ်ကြိမ် ထည့်ပါ။',
      'secret' => 'publishable key ကို ထည့်ပါ။',
      'url' => 'လိပ်စာသည် https:// ဖြင့် စရမည်။',
      _ => error,
    };
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
