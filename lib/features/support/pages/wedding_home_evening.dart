import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedding/core/data/models/partecipant.dart';
import 'package:wedding/core/data/services/api_service.dart';
import 'package:wedding/shared/constants/icon_size.dart';
import 'package:wedding/shared/constants/padding_values.dart';
import 'package:wedding/shared/constants/spacing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'wedding_list.dart';

class WeddingHomeEvening extends StatefulWidget {
  final ApiService apiService;

  const WeddingHomeEvening({super.key, required this.apiService}); // richiedi apiService

  @override
  State<WeddingHomeEvening> createState() => _WeddingHomeEveningState();
}

class _WeddingHomeEveningState extends State<WeddingHomeEvening> {
  final _formKey = GlobalKey<FormState>();

  void _resetForm() {
    setState(() {
      // 1. Resetta lo stato del Form (valida i messaggi di errore)
      _formKey.currentState?.reset();

      // 2. Svuota i controller testuali
      _nomeController.clear();
      _cognomeController.clear();
      _noteController.clear();

      // 3. Ripristina i valori di default
      _numeroAdultiController.text = '0';
      parteciperai = 'Si';
      allergiaSelezionata = 'Nessuna';
    });
  }

  String parteciperai = 'Si';

  // --- ALLERGIE ---
  final List<String> allergieDisponibili = ['Nessuna', 'Glutine', 'Lattosio', 'Frutta a guscio', 'Crostacei', 'Uova', 'Pesce', 'Altro'];

  String allergiaSelezionata = 'Nessuna';

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cognomeController = TextEditingController();
  final TextEditingController _numeroAdultiController = TextEditingController(text: '0');
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
      howManyKids: 0,
      allergies: allergiaSelezionata,
      allergiesNotes: '',
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
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text('Grazie!'),
            content: Text('La tua partecipazione è stata registrata.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
                child: Text('OK'),
              ),
            ],
          ),
        );

        // --- LOGICA DI RESET DOPO LA CHIUSURA ---
        _resetForm();
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
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: Text('Errore', style: TextStyle(color: Theme.of(context).colorScheme.error)),
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
      resizeToAvoidBottomInset: true,
      body: SelectionArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ---- BACKGROUND IMAGE ----
            Image.asset('assets/icons/bg.png', fit: BoxFit.cover),

            SafeArea(
              child: Align(
                alignment: Alignment.topCenter, // forza il contenuto a partire dall’alto
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(PaddingValues.p12),
                  physics: const ClampingScrollPhysics(),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              'Siamo felici di invitarvi a festeggiare il nostro matrimonio: un momento speciale che non sarebbe lo stesso senza di voi.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),

                            const SizedBox(height: PaddingValues.p10),

                            Text(
                              'Vi aspettiamo per il taglio della torta e per brindare insieme a Villa Vitturi, a partire dalle ore 21:00.',
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
                                  const SizedBox(width: PaddingValues.p10),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Parteciperai?*',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7),
                                      ),
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        'Sì',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7),
                                        ),
                                      ),
                                      value: 'Si',
                                      groupValue: parteciperai,
                                      onChanged: (v) => setState(() => parteciperai = v!),
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        'No',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7),
                                        ),
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
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (v) {
                                    if (v == null || v.isEmpty) return 'Campo obbligatorio';
                                    return null;
                                  },
                                ),

                                const SizedBox(height: PaddingValues.p16),

                                Text(
                                  'Spazio per NOTE',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                ),

                                TextFormField(
                                  controller: _noteController,
                                  minLines: 1,
                                  maxLines: 4,
                                  maxLength: 200,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    counterStyle: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                                    labelStyle: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.surfaceDim.withValues(alpha: 0.7)),
                                  ),
                                ),
                                const SizedBox(height: PaddingValues.p32),
                                SizedBox(
                                  child: ElevatedButton(
                                    onPressed: submitForm,
                                    child: Text(
                                      'Invia',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).colorScheme.onSecondary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: PaddingValues.p16),
                      // ---- CONTAINER IBAN & LISTA ----
                      Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 700),
                          padding: EdgeInsets.symmetric(horizontal: Spacing.h24, vertical: Spacing.v24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(
                                Icons.wallet_giftcard_rounded,
                                size: isDesktopOrTablet ? IconSize.s56 : IconSize.s40,
                                color: Theme.of(context).colorScheme.primary,
                              ),

                              // --- TESTO DI TRANSIZIONE CORDIALE ---
                              const SizedBox(height: PaddingValues.p16),
                              Text(
                                'Se desiderate farci un pensiero, abbiamo preparato una lista dedicata grazie di cuore!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.surfaceDim,
                                ),
                              ),

                              const SizedBox(height: PaddingValues.p16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WeddingList()));
                                },
                                child: Text(
                                  'Vai alla lista nozze',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Theme.of(context).colorScheme.onSecondary,
                                  ),
                                ),
                              ),

                              const SizedBox(height: PaddingValues.p16),

                              Text(
                                'Per chi desiderasse sostenere l\'inizio di questo nostro nuovo capitolo in modo diverso,',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ' è possibile contribuire direttamente al nostro fondo comune',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: PaddingValues.p10),
                              Text(
                                'IBAN: IT27K0874961742000000967536',
                                textAlign: TextAlign.center,
                                style: (isDesktopOrTablet ? Theme.of(context).textTheme.bodyMedium : Theme.of(context).textTheme.bodySmall)
                                    ?.copyWith(
                                      fontFamily: 'AtkinsonHyperlegibleMono',
                                      color: Theme.of(context).colorScheme.surfaceDim,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),

                              Text(
                                'Intestatario: Furlan Edoardo',
                                textAlign: TextAlign.center,
                                style: (isDesktopOrTablet ? Theme.of(context).textTheme.bodyMedium : Theme.of(context).textTheme.bodySmall)
                                    ?.copyWith(
                                      fontFamily: 'AtkinsonHyperlegibleMono',
                                      color: Theme.of(context).colorScheme.surfaceDim,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
