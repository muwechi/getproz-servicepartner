import 'package:flutter/material.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact & Support")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Card(
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.indigo),
                title: Text("Support Email"),
                subtitle: Text("support@getproz.com"),
              ),
            ),
            SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.indigo),
                title: Text("Partner Helpline"),
                subtitle: Text("+91 1800-123-4567"),
              ),
            ),
            SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: Icon(Icons.location_city, color: Colors.indigo),
                title: Text("Headquarters"),
                subtitle: Text("GoServices India Pvt. Ltd."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
