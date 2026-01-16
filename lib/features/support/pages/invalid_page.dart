import 'package:flutter/material.dart';
import 'package:wedding/features/support/pages/wedding_home_page.dart';
import 'package:wedding/shared/constants/padding_values.dart';
import 'package:wedding/shared/constants/spacing.dart';
import 'package:wedding/features/support/pages/wedding_home_evening.dart';
import 'package:wedding/core/data/services/api_service.dart';

class InvalidPage extends StatelessWidget {
  final ApiService apiService;

  const InvalidPage({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ---- BACKGROUND IMAGE ----
          Image.asset('assets/icons/bg.png', fit: BoxFit.cover),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(PaddingValues.p12),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  padding: EdgeInsets.symmetric(horizontal: isDesktopOrTablet ? Spacing.h49 : Spacing.h24, vertical: Spacing.v24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6))],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.link_off_rounded, size: isDesktopOrTablet ? 48 : 36, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: PaddingValues.p16),

                      Text(
                        'Link non valido',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onError),
                      ),

                      const SizedBox(height: PaddingValues.p16),

                      Text(
                        'Questo link non è attivo o non è valido.\n'
                        'Per accedere, utilizza il QR code ricevuto.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      const SizedBox(height: PaddingValues.p12),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => WeddingHomeEvening(apiService: apiService)));
                        },
                        child: const Text('Apri Home Sera (debug)'),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => WeddingHomePage(apiService: apiService)));
                        },
                        child: const Text('Apri Home Giorno (debug)'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
