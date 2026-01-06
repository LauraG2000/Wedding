import 'package:flutter/material.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class WeddingList extends StatelessWidget {
  const WeddingList({super.key});

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ---- BACKGROUND ----
          Image.asset('assets/icons/bg.png', fit: BoxFit.cover),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(PaddingValues.p12),
              child: Column(
                children: [
                  // ---- TITOLO ----
                  Text(
                    'Lista Matrimonio',
                    textAlign: TextAlign.center,
                    style: isDesktopOrTablet ? Theme.of(context).textTheme.displayLarge : Theme.of(context).textTheme.displayMedium,
                  ),

                  const SizedBox(height: PaddingValues.p10),

                  // ---- SOTTOTITOLO ----
                  Text(
                    'Laura & Edoardo',
                    textAlign: TextAlign.center,
                    style: (isDesktopOrTablet ? Theme.of(context).textTheme.displayLarge : Theme.of(context).textTheme.displayMedium)
                        ?.copyWith(
                          fontFamily: 'GreatVibes',
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.9),
                          letterSpacing: 1.2,
                          height: 1.3,
                        ),
                  ),

                  const SizedBox(height: PaddingValues.p24),

                  // ---- CONTAINER LISTA ----
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 700),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width < 600 ? Spacing.h24 : Spacing.h49,
                        vertical: Spacing.v24,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Il regalo più bello per noi è condividere questo giorno con voi.\n'
                            'Se desiderate farci un pensiero, qui trovate alcune idee che ci accompagneranno nel nostro futuro insieme.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),

                          const SizedBox(height: PaddingValues.p24),

                          // ---- ITEM 1 ----
                          InkWell(
                            onTap: () => _openLink('https://www.esempio-viaggio-nozze.it'),
                            child: Container(
                              padding: const EdgeInsets.all(PaddingValues.p16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.flight, color: Theme.of(context).colorScheme.primary),
                                  const SizedBox(width: PaddingValues.p16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Viaggio di nozze',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Un contributo per la nostra luna di miele',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.open_in_new, size: 18),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: PaddingValues.p16),

                          // ---- ITEM 2 ----
                          InkWell(
                            onTap: () => _openLink('https://www.esempio-arredamento.it'),
                            child: Container(
                              padding: const EdgeInsets.all(PaddingValues.p16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.chair, color: Theme.of(context).colorScheme.primary),
                                  const SizedBox(width: PaddingValues.p16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Casa & arredamento',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Dettagli per costruire il nostro nido',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.open_in_new, size: 18),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: PaddingValues.p16),

                          // ---- ITEM 3 ----
                          InkWell(
                            onTap: () => _openLink('https://www.esempio-esperienze.it'),
                            child: Container(
                              padding: const EdgeInsets.all(PaddingValues.p16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.favorite, color: Theme.of(context).colorScheme.primary),
                                  const SizedBox(width: PaddingValues.p16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Esperienze',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Momenti da vivere e ricordare',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.open_in_new, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: PaddingValues.p24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
