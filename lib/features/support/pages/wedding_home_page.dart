import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joyflo_project/core/data/models/partecipant.dart';
import 'package:joyflo_project/core/data/services/api_service.dart';
import 'package:joyflo_project/shared/constants/padding_values.dart';
import 'package:joyflo_project/shared/constants/spacing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'wedding_list.dart';

class WeddingHomePage extends StatefulWidget {
  final ApiService apiService; // aggiungi questa riga

  const WeddingHomePage({super.key, required this.apiService}); // richiedi apiService

  @override
  State<WeddingHomePage> createState() => _WeddingHomePageState();
}

class _WeddingHomePageState extends State<WeddingHomePage> {
  final _formKey = GlobalKey<FormState>();

  String parteciperai = 'Si';
  String bambini = 'No';

  // --- ALLERGIE ---
  final List<String> allergieDisponibili = ['Nessuna', 'Glutine', 'Lattosio', 'Frutta a guscio', 'Crostacei', 'Uova', 'Pesce', 'Altro'];

  String allergiaSelezionata = 'Nessuna';

  final TextEditingController _allergieManualiController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cognomeController = TextEditingController();
  final TextEditingController _numeroAdultiController = TextEditingController(text: '0');
  final TextEditingController _numeroBambiniController = TextEditingController(text: '0');
  final TextEditingController _noteController = TextEditingController();

  Future<void> openMaps(String address) async {
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Validazione Parteciperai?
    if (parteciperai != 'Si' && parteciperai != 'No') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Seleziona se parteciperai o meno')));
      return;
    }

    final partecipant = Partecipant(
      name: _nomeController.text.trim(),
      surName: _cognomeController.text.trim(),
      willJoin: parteciperai == 'Si',
      howManyTotals: int.tryParse(_numeroAdultiController.text) ?? 0,
      howManyKids: int.tryParse(_numeroBambiniController.text) ?? 0,
      allergies: allergiaSelezionata,
      allergiesNotes: _allergieManualiController.text.trim(),
      notes: _noteController.text.trim(),
    );

    try {
      final response = await widget.apiService.createPartecipant(partecipant);

      if (response.isSuccessful) {
        debugPrint('Partecipante inviato correttamente! ID: ${response.body['id']}');
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Grazie!'),
            content: const Text('La tua partecipazione è stata registrata.'),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
      } else {
        debugPrint('Errore API: ${response.statusCode} - ${response.error}');
        throw Exception('Errore durante l\'invio');
      }
    } catch (e) {
      debugPrint('Eccezione: $e');
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Errore'),
          content: const Text('Si è verificato un problema durante l\'invio.'),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Chiudi'))],
        ),
      );
    }
  }

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(PaddingValues.p12),
              child: Column(
                children: [
                  // ---- TITOLO ----
                  Text(
                    'Il nostro matrimonio',
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

                  // ---- CONTAINER INFO ----
                  Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width < 600 ? Spacing.h24 : Spacing.h49,
                      vertical: Spacing.v24,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Siamo felici di invitarvi al nostro matrimonio, un giorno per noi speciale da condividere con le persone che amiamo.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),

                        const SizedBox(height: PaddingValues.p10),

                        Text(
                          'La cerimonia e il ricevimento si terranno presso: Villa Vitturi alle ore 15:30,',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: PaddingValues.p10),

                        InkWell(
                          onTap: () => openMaps('Villa Vitturi, Via Saltore, 1, 31052 Saltore TV'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on, size: 25, color: Theme.of(context).colorScheme.primary),
                              const SizedBox(height: PaddingValues.p10),
                              Flexible(
                                child: Text(
                                  'Villa Vitturi, Via Saltore, 1, 31052 Saltore TV',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Theme.of(context).colorScheme.primary,
                                    decorationThickness: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: PaddingValues.p10),

                        Text(
                          'Per organizzare al meglio il nostro matrimonio, chiediamo di inserire i dati richiesti nel modulo '
                          'e di confermare la partecipazione.',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: PaddingValues.p24),

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
                            TextFormField(
                              controller: _nomeController,
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
                              controller: _cognomeController,
                              decoration: InputDecoration(
                                labelStyle: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                labelText: 'Cognome*',
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Campo obbligatorio' : null,
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            DropdownButtonFormField<String>(
                              initialValue: allergiaSelezionata,
                              decoration: InputDecoration(
                                labelText: 'Allergie',
                                labelStyle: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                              ),
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.9)),
                              items: allergieDisponibili
                                  .map(
                                    (allergia) => DropdownMenuItem(
                                      value: allergia,
                                      child: Text(
                                        allergia,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.9),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  allergiaSelezionata = value!;
                                });
                              },
                            ),

                            // --- MOSTRA IL CAMPO "ALTRE ALLERGIE" SOLO SE SELEZIONATO "ALTRO" ---
                            if (allergiaSelezionata == 'Altro') ...[
                              const SizedBox(height: PaddingValues.p16),
                              TextFormField(
                                controller: _allergieManualiController,
                                decoration: InputDecoration(
                                  labelText: 'Altre allergie (facoltativo)',
                                  hintText: 'Scrivi qui la tua allergia',
                                  labelStyle: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                ),
                                maxLines: 2,
                              ),
                            ],

                            const SizedBox(height: PaddingValues.p16),
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
                                if (parteciperai != 'Si' && parteciperai != 'No')
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0, top: 4),
                                    child: Text('Seleziona una risposta', style: TextStyle(color: Colors.red, fontSize: 12)),
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
                              controller: _numeroAdultiController,
                              decoration: const InputDecoration(labelText: 'n°'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Campo obbligatorio';
                                final value = int.tryParse(v);
                                if (value == null || value <= 0) return 'Inserisci un numero maggiore di 0';
                                return null;
                              },
                            ),

                            const SizedBox(height: PaddingValues.p16),

                            Text(
                              'Bambini',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                            ),

                            TextFormField(
                              controller: _numeroBambiniController,
                              decoration: const InputDecoration(labelText: 'n°'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                            const SizedBox(height: PaddingValues.p16),

                            Text(
                              'Spazio per note (es: vegano/a)',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                            ),

                            TextFormField(
                              controller: _noteController,
                              decoration: InputDecoration(
                                labelStyle: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                labelText: 'Note',
                              ),
                              maxLines: 3,
                            ),
                            const SizedBox(height: PaddingValues.p32),
                            ElevatedButton(
                              onPressed: submitForm, // <- qui chiami direttamente la funzione
                              child: const Text('Invia'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: PaddingValues.p24),
                  // ---- CONTAINER IBAN & LISTA ----
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
                            'Se desiderate farci un pensiero, grazie di cuore!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: PaddingValues.p10),
                          Text(
                            'IBAN: IT12A34567B8901234567890123',
                            textAlign: TextAlign.center,
                            style: (isDesktopOrTablet ? Theme.of(context).textTheme.bodyMedium : Theme.of(context).textTheme.bodySmall)
                                ?.copyWith(
                                  fontFamily: 'AtkinsonHyperlegibleMono',
                                  color: Theme.of(context).colorScheme.surfaceDim,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                          // --- TESTO DI TRANSIZIONE CORDIALE ---
                          const SizedBox(height: PaddingValues.p24),
                          Text(
                            'In alternativa, per chi preferisse sostenere l\'inizio del nostro viaggio insieme in un altro modo, abbiamo preparato una lista dedicata:',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.8),
                            ),
                          ),

                          const SizedBox(height: PaddingValues.p16),

                          // --- PULSANTE LISTA MATRIMONIO ---
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WeddingList()));
                            },
                            child: const Text('Vai alla lista matrimonio'),
                          ),
                        ],
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
