import 'package:flutter/material.dart';

class BankEditView extends StatefulWidget {
  const BankEditView({super.key});

  @override
  State<BankEditView> createState() => _BankEditViewState();
}

class _BankEditViewState extends State<BankEditView> {
  final _bankNameController = TextEditingController();
  final _accHolderController = TextEditingController();
  final _accNoController = TextEditingController();
  final _ifscController = TextEditingController();

  void _saveBankDetails() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Bank details updated successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bank Account Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _bankNameController,
              decoration: InputDecoration(
                labelText: "Bank Name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _accHolderController,
              decoration: InputDecoration(
                labelText: "Account Holder Name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _accNoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Account Number",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ifscController,
              decoration: InputDecoration(
                labelText: "IFSC Code",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveBankDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("SAVE BANK DETAILS", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
