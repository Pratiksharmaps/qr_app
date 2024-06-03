import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_app/provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upiId = ref.watch(upiIdProvider);
    final upiName = ref.watch(upiNameProvider);
    final upiAmount = ref.watch(upiAmountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'UPI ID'),
                onChanged: (value) => ref.read(upiIdProvider.notifier).state = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => ref.read(upiNameProvider.notifier).state = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                onChanged: (value) => ref.read(upiAmountProvider.notifier).state = value,
              ),
              const SizedBox(height: 40),
              if (upiId.isNotEmpty && upiName.isNotEmpty && upiAmount.isNotEmpty)
                QrImageView(
                  data: 'upi://pay?pa=$upiId&pn=$upiName&am=$upiAmount',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              if (upiId.isEmpty || upiName.isEmpty || upiAmount.isEmpty)
               const  Text('Please fill in all fields to generate the QR code'),
            ],
          ),
        ),
      ),
    );
  }
}