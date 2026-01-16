import 'package:flutter/material.dart';
import 'package:wedding/shared/constants/icon_size.dart';
import 'package:wedding/shared/constants/padding_values.dart';
import 'package:wedding/shared/constants/spacing.dart';
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
      body: SelectionArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ---- BACKGROUND ----
            Image.asset('assets/icons/bg.png', fit: BoxFit.cover),

            // ---- CONTENUTO (SOTTO) ----
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(PaddingValues.p12),
                child: Column(
                  children: [
                    Text(
                      'Lista Matrimonio',
                      textAlign: TextAlign.center,
                      style: isDesktopOrTablet ? Theme.of(context).textTheme.displayLarge : Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: PaddingValues.p10),

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

                    const SizedBox(height: PaddingValues.p12),

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

                            const SizedBox(height: PaddingValues.p16),

                            Text(
                              'Prima di qualsiasi acquisto,',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                            ),

                            Text(
                              'vi chiediamo gentilmente di contattare la mamma di Laura su WhatsApp per evitare regali doppi o per qualsiasi informazione.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),

                            const SizedBox(height: PaddingValues.p12),

                            Text(
                              'Mara Cell.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                            ),

                            Text(
                              '+39 3894449387',
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w300, fontFamily: 'AtkinsonHyperlegibleMono'),
                            ),

                            const SizedBox(height: PaddingValues.p12),

                            Text(
                              'Idee regalo – Budget 100 / 170',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            _item(
                              context,
                              icon: Icons.luggage,
                              iconSize: IconSize.s32,
                              title: 'Valigia S',
                              subtitle: 'Un contributo per la nostra luna di miele',
                              link: 'https://www.amazon.it/dp/B0CX55DWYJ',
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            _item(
                              context,
                              icon: Icons.width_wide_outlined,
                              iconSize: IconSize.s27,
                              title: 'Tappeto Sari Moderno (PRIMA scelta tra i tappeti)',
                              subtitle:
                                  'Dimensione: 140x190 cm -> Se dovesse risultare esaurito, abbiamo selezionato un\'alternativa simile che trovate qui sotto',
                              link:
                                  'https://tapiso.it/cassa/?_gl=1*12e15pc*_up*MQ..*_ga*MTM4MzIwODIzMy4xNzY4NDMxNTc1*_ga_C3SEW66PC6*czE3Njg0MzE1NzQkbzEkZzAkdDE3Njg0MzE1NzQkajYwJGwwJGg0ODc1MTk4Njg.',
                            ),

                            _item(
                              context,
                              icon: Icons.width_wide_outlined,
                              iconSize: IconSize.s27,
                              title: 'Tappeto Crystal (seconda scelta in caso di esaurimento del precedente)',
                              subtitle: 'Dimensione: 140x200cm - colore: Marrone Beige Crema',
                              link:
                                  'https://tapiso.it/cassa/?_gl=1*1bjz68a*_up*MQ..*_ga*MzQ0MjI0NDYxLjE3Njg0MzE0NTI.*_ga_C3SEW66PC6*czE3Njg0MzE0NDkkbzEkZzAkdDE3Njg0MzE0NDkkajYwJGwwJGg5MDk0MTk4MDA.',
                            ),

                            const SizedBox(height: PaddingValues.p16),

                            Text(
                              'Idee regalo – Budget 200 / 250',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            _item(
                              context,
                              icon: Icons.luggage,
                              iconSize: IconSize.s48,
                              title: 'Valigia L',
                              subtitle: 'Un contributo per la nostra luna di miele',
                              link: 'https://www.amazon.it/dp/B0CX53SSP6',
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            _item(
                              context,
                              icon: Icons.table_bar_outlined,
                              iconSize: IconSize.s27,
                              title: 'Tavolino ovale (PRIMA scelta tra i tavolini)',
                              subtitle: 'Colore: nero',
                              link:
                                  'https://www.maisonsdumonde.com/IT/it/p/tavolino-ovale-con-piano-sollevabile-effetto-legno-nero-gaby-M25012527.htm',
                            ),
                            _item(
                              context,
                              icon: Icons.table_bar_outlined,
                              iconSize: IconSize.s27,
                              title: 'Tavolino in magnesite (seconda scelta in caso di esaurimento del precedente)',
                              subtitle: 'Colore: nero',
                              link:
                                  'https://www.maisonsdumonde.com/IT/it/p/tavolino-da-salotto-interno-esterno-in-magnesite-nera-M25155173.htm',
                            ),

                            const SizedBox(height: PaddingValues.p24),

                            Text(
                              'Idee regalo – Budget 260+',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            _item(
                              context,
                              icon: Icons.light,
                              iconSize: IconSize.s27,
                              title: 'Lampada da terra (x2)',
                              subtitle: 'Ci piacerebbe una coppia di queste lampade per il soggiorno',
                              link: 'https://www.amazon.it/ALEEIK-Semplice-Paralume-Illuminazione-Soggiorno/dp/B0CP9CTGYF',
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

            // ---- BACK BUTTON (SOPRA TUTTO) ----
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required IconData icon,
    required double iconSize,
    required String title,
    String? subtitle,
    required String link,
  }) {
    return InkWell(
      onTap: () => _openLink(link),
      child: Container(
        padding: const EdgeInsets.all(PaddingValues.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: Spacing.h50,
              child: Center(
                child: Icon(icon, size: iconSize, color: Theme.of(context).colorScheme.primary),
              ),
            ),

            const SizedBox(width: PaddingValues.p16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(
                    subtitle ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.8)),
                  ),
                ],
              ),
            ),

            const Icon(Icons.open_in_new, size: 18),
          ],
        ),
      ),
    );
  }
}
