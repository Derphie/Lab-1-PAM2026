import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversie Monedă',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  // Cursuri valutare fixe, raportate la 1 EUR (moneda de bază internă)
  final Map<String, double> _ratesToEur = {
    'MDL': 19.50,
    'EUR': 1.0,
    'USD': 1.08,
    'RON': 4.97,
    'GBP': 0.85,
  };

  final TextEditingController _amountController = TextEditingController();

  String _fromCurrency = 'MDL';
  String _toCurrency = 'EUR';
  String _result = '';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _convert() {
    final String rawText = _amountController.text.trim().replaceAll(',', '.');
    
    if (rawText.isEmpty) {
      setState(() {
        _result = '';
      });
      return;
    }

    final double? amount = double.tryParse(rawText);

    if (amount == null) {
      setState(() {
        _result = 'Introduceți o sumă validă';
      });
      return;
    }

    // Conversie: sursă -> EUR -> destinație
    final double rateFrom = _ratesToEur[_fromCurrency]!;
    final double rateTo = _ratesToEur[_toCurrency]!;
    final double amountInEur = amount / rateFrom;
    final double convertedAmount = amountInEur * rateTo;

    setState(() {
      _result =
          '${amount.toStringAsFixed(2)} $_fromCurrency = ${convertedAmount.toStringAsFixed(2)} $_toCurrency';
    });
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
    });
    _convert();
  }

  @override
  Widget build(BuildContext context) {
    final currencies = _ratesToEur.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversie Monedă'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            // Input pentru sumă
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Sumă',
                hintText: 'Introduceți suma de convertit',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              onChanged: (value) => _convert(),
            ),
            const SizedBox(height: 20),

            // Dropdown Moneda Sursă
            Row(
              children: [
                const Text('Din: ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: _fromCurrency,
                    isExpanded: true,
                    items: currencies.map((currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _fromCurrency = value;
                        });
                        _convert();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Buton Inversare
            Center(
              child: IconButton(
                icon: const Icon(Icons.swap_vert, size: 28),
                tooltip: 'Inversează monedele',
                onPressed: _swapCurrencies,
              ),
            ),

            // Dropdown Moneda Destinație
            Row(
              children: [
                const Text('În:  ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: _toCurrency,
                    isExpanded: true,
                    items: currencies.map((currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _toCurrency = value;
                        });
                        _convert();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Afișare Rezultat
            Text(
              _result,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
