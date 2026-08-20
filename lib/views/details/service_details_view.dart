import 'package:flutter/material.dart';
import '../../models/lead_model.dart';

class ServiceDetailsView extends StatefulWidget {
  const ServiceDetailsView({super.key});

  @override
  State<ServiceDetailsView> createState() => _ServiceDetailsViewState();
}

class _ServiceDetailsViewState extends State<ServiceDetailsView> {
  bool _isStarted = false;
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final lead = ModalRoute.of(context)?.settings.arguments as LeadModel? ??
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
        );

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking ${lead.bookingId}"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lead.categoryName ?? "",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(lead.serviceName ?? "", style: const TextStyle(color: Colors.grey)),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Service Price:", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(lead.price ?? "", style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Date & Time:", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("${lead.date ?? ''} ${lead.time ?? ''}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Customer Information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.indigo),
                      title: Text(lead.userName ?? "N/A"),
                      subtitle: Text(lead.userPhone ?? ""),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.indigo),
                      title: Text(lead.address ?? "Location N/A"),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (!_isCompleted) ...[
              if (!_isStarted)
                ElevatedButton(
                  onPressed: () {
                    setState(() => _isStarted = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Job Started successfully!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("START JOB", style: TextStyle(color: Colors.white, fontSize: 16)),
                )
              else
                ElevatedButton(
                  onPressed: () {
                    setState(() => _isCompleted = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Job Marked as Completed!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("MARK AS COMPLETE", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
            ] else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "✓ This job has been completed successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
