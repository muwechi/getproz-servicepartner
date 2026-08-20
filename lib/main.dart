import 'package:flutter/material.dart';
import 'views/auth/splash_view.dart';
import 'views/auth/login_view.dart';
import 'views/auth/signup_view.dart';
import 'views/auth/forgot_password_view.dart';
import 'views/auth/otp_view.dart';
import 'views/dashboard/main_dashboard.dart';
import 'views/details/service_details_view.dart';
import 'views/details/bank_edit_view.dart';
import 'views/details/gst_details_view.dart';
import 'views/details/terms_view.dart';
import 'views/details/contact_view.dart';

void main() {
  runApp(const GoServicesPartnerApp());
}

class GoServicesPartnerApp extends StatelessWidget {
  const GoServicesPartnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoServices Partner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/login': (context) => const LoginView(),
        '/signup': (context) => const SignupView(),
        '/forgot-password': (context) => const ForgotPasswordView(),
        '/otp': (context) => const OtpView(),
        '/dashboard': (context) => const MainDashboard(),
        '/service-details': (context) => const ServiceDetailsView(),
        '/bank-edit': (context) => const BankEditView(),
        '/gst-details': (context) => const GstDetailsView(),
        '/terms': (context) => const TermsView(),
        '/contact': (context) => const ContactView(),
      },
    );
  }
}
