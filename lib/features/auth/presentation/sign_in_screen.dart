import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/providers.dart';
import 'sign_in_controller.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shop = ref.watch(shopProfileProvider);
    final signIn = ref.watch(signInControllerProvider);
    final online = ref.watch(onlineProvider).value ?? false;
    final controller = ref.read(signInControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Kasa Shop', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                  const Spacer(),
                  _OfflinePill(online: online),
                ],
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 420),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: KasaColors.card,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
                                child: shop.when(
                          loading: () => const SizedBox(height: 240, child: Center(child: CircularProgressIndicator())),
                          error: (error, stack) => Text('ဒေတာဖွင့်မရပါ။ $error'),
                          data: (profile) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.storefront, size: 56, color: KasaColors.brown),
                              const SizedBox(height: 12),
                              Text(profile.displayName, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 4),
                              const Text('အရောင်းစနစ်', style: TextStyle(color: KasaColors.muted)),
                              const SizedBox(height: 28),
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('PIN နံပါတ်', style: TextStyle(fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8),
                                    _PinBoxes(pin: signIn.pin),
                                  ],
                                ),
                              ),
                              if (signIn.error != null) ...[
                                const SizedBox(height: 10),
                                Text(signIn.error!, style: const TextStyle(color: KasaColors.danger)),
                              ],
                              const SizedBox(height: 16),
                              _Keypad(enabled: !signIn.submitting, onDigit: controller.pushDigit, onBackspace: controller.backspace),
                            ],
                          ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(online ? Icons.wifi : Icons.wifi_off, size: 16, color: KasaColors.muted),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      online ? 'အင်တာနက်ရှိပါသည်။ ပြတ်သွားရင်လည်း ဆက်အသုံးပြုနိုင်ပါသည်။' : 'အော့ဖ်လိုင်းဖြစ်နေပါသည်။ အင်တာနက်မရှိလည်း ဝင်ရောက်အသုံးပြုနိုင်ပါသည်။',
                      style: const TextStyle(color: KasaColors.muted),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfflinePill extends StatelessWidget {
  const _OfflinePill({required this.online});

  final bool online;

  @override
  Widget build(BuildContext context) {
    final color = online ? KasaColors.online : KasaColors.danger;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(online ? 'အွန်လိုင်း' : 'အော့ဖ်လိုင်း', style: TextStyle(color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _PinBoxes extends StatelessWidget {
  const _PinBoxes({required this.pin});

  final String pin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        final filled = index < pin.length;
        final active = index == pin.length;
        return Container(
          width: 52,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: active ? KasaColors.brown : KasaColors.line, width: active ? 1.6 : 1),
          ),
          child: filled ? const Text('•', style: TextStyle(fontSize: 28, height: 1)) : null,
        );
      }),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({required this.enabled, required this.onDigit, required this.onBackspace});

  final bool enabled;
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '⌫'];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.7,
      children: keys.map((key) {
        if (key.isEmpty) return const SizedBox.shrink();
        return Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: !enabled
                ? null
                : () {
                    if (key == '⌫') {
                      onBackspace();
                    } else {
                      onDigit(key);
                    }
                  },
            child: Center(child: Text(key, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500))),
          ),
        );
      }).toList(),
    );
  }
}
