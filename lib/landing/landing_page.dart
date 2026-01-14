import 'package:flutter/material.dart';
import 'package:wedding/core/data/services/api_service.dart';
import 'package:wedding/features/support/pages/wedding_home_evening.dart';
import 'package:wedding/features/support/pages/wedding_home_page.dart';
import 'package:wedding/features/support/pages/invalid_page.dart';

class LandingPage extends StatefulWidget {
  final ApiService apiService;

  const LandingPage({super.key, required this.apiService});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uri = Uri.base;
      final mode = uri.queryParameters['mode'];

      // ☀️ SOLO QR giorno
      if (mode == 'day') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WeddingHomePage(apiService: widget.apiService)));
        return;
      }

      // 🌙 SOLO QR sera
      if (mode == 'night') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WeddingHomeEvening(apiService: widget.apiService)));
        return;
      }

      // ❌ QUALSIASI ALTRO CASO (compreso solo dominio)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => InvalidPage(apiService: widget.apiService)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
