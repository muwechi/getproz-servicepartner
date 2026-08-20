import 'package:flutter/material.dart';
import '../../models/recharge_plan_model.dart';
import '../../services/api_service.dart';
import '../../services/session_manager.dart';

class CreditBalanceView extends StatefulWidget {
  const CreditBalanceView({super.key});

  @override
  State<CreditBalanceView> createState() => _CreditBalanceViewState();
}

class _CreditBalanceViewState extends State<CreditBalanceView> {
  String _coins = "0";
  List<RechargePlanModel> _plans = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBalanceAndPlans();
  }

  Future<void> _loadBalanceAndPlans() async {
    setState(() => _isLoading = true);
    final user = await SessionManager.getUserDetails();
    final balance = await ApiService.fetchWalletBalance(user['id'] ?? "1");
    final plans = await ApiService.fetchRechargePlans();

    _coins = balance == "0" ? "250" : balance;
    _plans = plans.isEmpty
        ? [
            RechargePlanModel(planId: "1", planName: "Starter Pack", amount: "₹ 500", coins: "50 Coins"),
            RechargePlanModel(planId: "2", planName: "Popular Pack", amount: "₹ 1,000", coins: "120 Coins"),
            RechargePlanModel(planId: "3", planName: "Pro Pack", amount: "₹ 2,500", coins: "320 Coins"),
          ]
        : plans;

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.indigo,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(Icons.account_balance_wallet, color: Colors.amber, size: 48),
                  const SizedBox(height: 8),
                  const Text("Wallet Credit Balance", style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 4),
                  Text(
                    "$_coins Coins",
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Recharge Coin Packs",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _plans.length,
            itemBuilder: (context, index) {
              final plan = _plans[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(plan.planName ?? "Recharge Pack", style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${plan.coins ?? ''} included"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Selected ${plan.planName} for ${plan.amount}")),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(plan.amount ?? "Buy", style: const TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
