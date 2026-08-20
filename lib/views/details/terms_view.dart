import 'package:flutter/material.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms & Conditions")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "GoServices Partner Terms & Conditions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "1. Partners agree to provide professional service to customers.\n"
              "2. Coin packages purchased are used to claim customer leads.\n"
              "3. Cancellation and refund policies apply according to company standards.\n"
              "4. Partners must maintain quality work and punctuality.\n"
              "5. All personal data is securely handled in compliance with applicable laws.",
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
