import 'package:flutter/material.dart';
import '../../services/session_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Map<String, String> _user = {};

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final details = await SessionManager.getUserDetails();
    setState(() => _user = details);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            _user['name']?.isNotEmpty == true ? _user['name']! : "Service Partner",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(_user['mobile'] ?? "", style: const TextStyle(color: Colors.grey)),
          Text(_user['email'] ?? "", style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_balance, color: Colors.indigo),
            title: const Text("Bank Account Details"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/bank-edit'),
          ),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.indigo),
            title: const Text("GST & Documentation"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/gst-details'),
          ),
          ListTile(
            leading: const Icon(Icons.policy, color: Colors.indigo),
            title: const Text("Terms & Conditions"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/terms'),
          ),
          ListTile(
            leading: const Icon(Icons.support_agent, color: Colors.indigo),
            title: const Text("Contact & Support"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/contact'),
          ),
          const Divider(),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text("LOGOUT", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () async {
                await SessionManager.logout();
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          )
        ],
      ),
    );
  }
}
