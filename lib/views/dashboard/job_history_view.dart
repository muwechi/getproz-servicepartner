import 'package:flutter/material.dart';
import '../../models/lead_model.dart';
import '../../services/api_service.dart';
import '../../services/session_manager.dart';

class JobHistoryView extends StatefulWidget {
  const JobHistoryView({super.key});

  @override
  State<JobHistoryView> createState() => _JobHistoryViewState();
}

class _JobHistoryViewState extends State<JobHistoryView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<LeadModel> _ongoingJobs = [];
  List<LeadModel> _completedJobs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    setState(() => _isLoading = true);
    final user = await SessionManager.getUserDetails();
    final ongoing = await ApiService.fetchOngoing(user['id'] ?? "1");
    final history = await ApiService.fetchHistory(user['id'] ?? "1");

    _ongoingJobs = ongoing.isEmpty
        ? [
            LeadModel(
              bookingId: "GS1003",
              categoryName: "Home Cleaning",
              serviceName: "Deep Bathroom & Kitchen Cleaning",
              price: "₹ 1,299",
              status: "Ongoing",
              userName: "Priya Patel",
              userPhone: "+91 9988776655",
              address: "DLF Phase 3, Gurugram, HR",
            )
          ]
        : ongoing;

    _completedJobs = history.isEmpty
        ? [
            LeadModel(
              bookingId: "GS0988",
              categoryName: "Electrical Repair",
              serviceName: "Switchboard & Wiring Repair",
              price: "₹ 350",
              status: "Completed",
              userName: "Suresh Kumar",
              userPhone: "+91 9811223344",
              address: "Vasant Kunj, New Delhi",
            )
          ]
        : history;

    setState(() => _isLoading = false);
  }

  Widget _buildJobList(List<LeadModel> list, bool isOngoing) {
    if (list.isEmpty) {
      return const Center(child: Text("No jobs found"));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final job = list[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              job.categoryName ?? "Service",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(job.serviceName ?? ""),
                const SizedBox(height: 4),
                Text("Customer: ${job.userName ?? 'N/A'} (${job.userPhone ?? ''})"),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  job.price ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Chip(
                  labelStyle: const TextStyle(color: Colors.white, fontSize: 10),
                  backgroundColor: isOngoing ? Colors.orange : Colors.green,
                  label: Text(isOngoing ? "Ongoing" : "Completed"),
                )
              ],
            ),
            onTap: () => Navigator.pushNamed(context, '/service-details', arguments: job),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jobs & Booking History"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Ongoing Jobs"),
            Tab(text: "Completed History"),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildJobList(_ongoingJobs, true),
                _buildJobList(_completedJobs, false),
              ],
            ),
    );
  }
}
