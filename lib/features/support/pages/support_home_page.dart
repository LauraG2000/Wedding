import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';

class SupportHomePage extends StatefulWidget {
  const SupportHomePage({super.key});

  @override
  State<SupportHomePage> createState() => _SupportHomePageState();
}

class _SupportHomePageState extends State<SupportHomePage> {
  final _formKey = GlobalKey<FormState>();

  String parteciperai = 'Si';
  String bambini = 'No';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ---- BACKGROUND IMAGE ----
          Image.asset('assets/icons/bg.png', fit: BoxFit.cover),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // ---- TITOLO ----
                  Text('Il nostro matrimonio', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),

                  // ---- SOTTOTITOLO ----
                  Text(
                    'Laura e Edoardo',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                  ),

                  const SizedBox(height: PaddingValues.p24),

                  // ---- CONTAINER INFO ----
                  Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Siamo felici di condividere con voi questo giorno speciale.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Villa Aurora\nVia delle Rose 12, Firenze',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.surfaceDim),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: PaddingValues.p32),

                  // ---- CONTAINER FORM (IDENTICO AL TUO) ----
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 700),
                      padding: EdgeInsets.symmetric(horizontal: Spacing.h24, vertical: Spacing.v24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6))],
                      ),

                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // RichText(
                            //   text: TextSpan(
                            //     style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim),
                            //     children: [
                            //       TextSpan(
                            //         text:
                            //             'Per organizzare al meglio il nostro matrimonio, '
                            //             'chiediamo di inserire i dati richiesti nel modulo '
                            //             'e di confermare la partecipazione ',
                            //       ),
                            //       TextSpan(
                            //         text: 'entro l’8 giugno 2026',
                            //         style: TextStyle(
                            //           decoration: TextDecoration.underline,
                            //           color: Theme.of(context).colorScheme.surfaceDim,
                            //           decorationColor: Theme.of(context).colorScheme.surfaceDim,
                            //           decorationThickness: 2,
                            //         ),
                            //       ),
                            //       TextSpan(text: '.'),
                            //     ],
                            //   ),
                            // ),

                            // const SizedBox(height: PaddingValues.p24),
                            TextFormField(
                              decoration: InputDecoration(
                                labelStyle: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                labelText: 'Nome*',
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Campo obbligatorio' : null,
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            TextFormField(
                              decoration: InputDecoration(
                                labelStyle: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                labelText: 'Cognome*',
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Campo obbligatorio' : null,
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            TextFormField(
                              decoration: InputDecoration(
                                labelStyle: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                labelText: 'Allergie*',
                                hintText: 'Aggiungi il nome / i nomi associati all’allergia',
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(height: PaddingValues.p24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Parteciperai?*',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                ),
                                RadioListTile(
                                  title: Text(
                                    'Sì',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                  ),
                                  value: 'Si',
                                  groupValue: parteciperai,
                                  onChanged: (v) => setState(() => parteciperai = v!),
                                ),
                                RadioListTile(
                                  title: Text(
                                    'No',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                  ),
                                  value: 'No',
                                  groupValue: parteciperai,
                                  onChanged: (v) => setState(() => parteciperai = v!),
                                ),
                              ],
                            ),

                            const SizedBox(height: PaddingValues.p16),

                            Text(
                              'In quanti sarete?*',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                            ),

                            TextFormField(
                              decoration: const InputDecoration(labelText: 'n°'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                            const SizedBox(height: PaddingValues.p24),

                            Text(
                              'Bambini*',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                            ),

                            TextFormField(
                              decoration: const InputDecoration(labelText: 'n°'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            Text(
                              'Spazio per note (es: vegano/a)*',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                labelStyle: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                labelText: 'Note*',
                              ),
                              maxLines: 3,
                            ),
                            const SizedBox(height: PaddingValues.p32),

                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // submit
                                }
                              },
                              child: const Text('Invia'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
