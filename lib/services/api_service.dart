import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/config.dart';
import '../models/lead_model.dart';
import '../models/recharge_plan_model.dart';

class ApiService {
  static Future<Map<String, dynamic>> login(String mobile, String password) async {
    try {
      final response = await http.post(
        Uri.parse(Config.loginUrl),
        body: {'mobile': mobile, 'password': password},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (_) {}
    return {'status': '0', 'message': 'Network error'};
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Config.signUpUrl),
        body: {
          'name': name,
          'email': email,
          'mobile': mobile,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (_) {}
    return {'status': '0', 'message': 'Network error'};
  }

  static Future<List<LeadModel>> fetchLeads(String partnerId) async {
    try {
      final response = await http.post(
        Uri.parse(Config.leadListUrl),
        body: {'partner_id': partnerId},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'] is List) {
          return (data['data'] as List)
              .map((item) => LeadModel.fromJson(item))
              .toList();
        }
      }
    } catch (_) {}
    return [];
  }

  static Future<List<LeadModel>> fetchOngoing(String partnerId) async {
    try {
      final response = await http.post(
        Uri.parse(Config.onGoingUrl),
        body: {'partner_id': partnerId},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'] is List) {
          return (data['data'] as List)
              .map((item) => LeadModel.fromJson(item))
              .toList();
        }
      }
    } catch (_) {}
    return [];
  }

  static Future<List<LeadModel>> fetchHistory(String partnerId) async {
    try {
      final response = await http.post(
        Uri.parse(Config.historyUrl),
        body: {'partner_id': partnerId},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'] is List) {
          return (data['data'] as List)
              .map((item) => LeadModel.fromJson(item))
              .toList();
        }
      }
    } catch (_) {}
    return [];
  }

  static Future<List<RechargePlanModel>> fetchRechargePlans() async {
    try {
      final response = await http.get(Uri.parse(Config.rechargePlanUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'] is List) {
          return (data['data'] as List)
              .map((item) => RechargePlanModel.fromJson(item))
              .toList();
        }
      }
    } catch (_) {}
    return [];
  }

  static Future<String> fetchWalletBalance(String partnerId) async {
    try {
      final response = await http.post(
        Uri.parse(Config.coinsUrl),
        body: {'partner_id': partnerId},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['coins']?.toString() ?? "0";
      }
    } catch (_) {}
    return "0";
  }
}
