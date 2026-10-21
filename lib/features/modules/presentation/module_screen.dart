import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/widgets/register_bar.dart';

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RegisterBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('ဒီစာမျက်နှာကို နောက်တစ်ဆင့်မှာ ဆက်လုပ်ပါမည်။', style: TextStyle(color: KasaColors.muted)),
            ],
          ),
        ),
      ),
    );
  }
}
