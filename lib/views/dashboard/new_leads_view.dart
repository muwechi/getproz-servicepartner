import 'package:flutter/material.dart';
import '../../models/lead_model.dart';
import '../../services/api_service.dart';
import '../../services/session_manager.dart';

class NewLeadsView extends StatefulWidget {
  const NewLeadsView({super.key});

  @override
  State<NewLeadsView> createState() => _NewLeadsViewState();
}

class _NewLeadsViewState extends State<NewLeadsView> {
  List<LeadModel> _leads = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLeads();
  }

  Future<void> _loadLeads() async {
    setState(() => _isLoading = true);
    final user = await SessionManager.getUserDetails();
    final leads = await ApiService.fetchLeads(user['id'] ?? "1");
    if (leads.isEmpty) {
      // Demo leads if server list is empty
      _leads = [
        LeadModel(
          bookingId: "GS1001",
          categoryName: "AC Repair & Service",
          serviceName: "AC General Servicing & Filter Cleaning",
          price: "₹ 499",
          coins: "10 Coins",
          date: "2026-08-06",
          time: "10:00 AM",
          userName: "Rahul Sharma",
          userPhone: "+91 9876543210",
          address: "Sector 62, Noida, UP",
        ),
        LeadModel(
          bookingId: "GS1002",
          categoryName: "Plumbing Service",
          serviceName: "Tap Repair & Leakage Fixing",
          price: "₹ 299",
          coins: "5 Coins",
          date: "2026-08-06",
          time: "02:30 PM",
          userName: "Ankit Verma",
          userPhone: "+91 9123456789",
          address: "Indirapuram, Ghaziabad, UP",
        ),
      ];
    } else {
      _leads = leads;
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _loadLeads,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _leads.length,
        itemBuilder: (context, index) {
          final lead = _leads[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lead.bookingId ?? "ID: N/A",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          lead.coins ?? "Coins",
                          style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Text(
                    lead.categoryName ?? "Service",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(lead.serviceName ?? "", style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          lead.address ?? "Location available upon acceptance",
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lead.price ?? "",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/service-details', arguments: lead);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("BUY / ACCEPT", style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
