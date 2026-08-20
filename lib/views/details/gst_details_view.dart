import 'package:flutter/material.dart';

class GstDetailsView extends StatefulWidget {
  const GstDetailsView({super.key});

  @override
  State<GstDetailsView> createState() => _GstDetailsViewState();
}

class _GstDetailsViewState extends State<GstDetailsView> {
  final _gstNoController = TextEditingController();
  final _panNoController = TextEditingController();

  void _saveDetails() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Documentation details saved!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GST & Documentation")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _panNoController,
              decoration: InputDecoration(
                labelText: "PAN Card Number",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _gstNoController,
              decoration: InputDecoration(
                labelText: "GST Number (Optional)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("SAVE DOCUMENTATION", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
