import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedding/core/data/services/api_service.dart';
import 'core/themes/themes.dart';
import 'landing/landing_page.dart';

void main() {
  // Inizializziamo il servizio Chopper come singleton
  final ApiService apiService = ApiService.create(baseUrl: 'http://34.122.221.12:8000');

  // ''
  //  '/api/'

  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;

  const MyApp({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wedding',
      theme: Themes.mainTheme.copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, surfaceTintColor: Colors.transparent),
      ),
      home: LandingPage(apiService: apiService),
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: child!,
        );
      },
    );
  }
}
