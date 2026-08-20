import 'package:flutter/material.dart';
import '../../services/session_manager.dart';
import 'new_leads_view.dart';
import 'job_history_view.dart';
import 'credit_balance_view.dart';
import 'profile_view.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  Map<String, String> _user = {};

  final List<Widget> _pages = const [
    NewLeadsView(),
    JobHistoryView(),
    CreditBalanceView(),
    ProfileView(),
  ];

  final List<String> _titles = const [
    "New Leads",
    "Jobs History",
    "Wallet & Credits",
    "Partner Profile",
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.indigo),
              accountName: Text(_user['name']?.isNotEmpty == true ? _user['name']! : "Service Partner"),
              accountEmail: Text(_user['mobile'] ?? ""),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.indigo, size: 36),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.flash_on),
              title: const Text("New Leads"),
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text("Jobs History"),
              onTap: () {
                setState(() => _selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text("Credit Balance"),
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                setState(() => _selectedIndex = 3);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text("Bank Details"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/bank-edit');
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text("GST Documentation"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/gst-details');
              },
            ),
            ListTile(
              leading: const Icon(Icons.policy),
              title: const Text("Terms & Conditions"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/terms');
              },
            ),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/contact');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () async {
                await SessionManager.logout();
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: "Leads"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
