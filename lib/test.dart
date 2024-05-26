// lib/screens/currency_converter.dart
import 'package:flutter/material.dart';
import '/currency_service.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double usdToEuro = 0.0;
  double euroToUsd = 0.0;
  TextEditingController usdController = TextEditingController();
  TextEditingController euroController = TextEditingController();
  CurrencyService currencyService = CurrencyService();

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  fetchCurrencies() async {
    try {
      Map<String, double> rates = await currencyService.fetchCurrencies();
      setState(() {
        usdToEuro = rates['usdToEuro']!;
        euroToUsd = rates['euroToUsd']!;
      });
    } catch (e) {
      print(e);
    }
  }

  convertUsdToEuro() {
    String input = usdController.text;
    if (input.isNotEmpty) {
      double usd = double.parse(input);
      double euro = usd * usdToEuro;
      euroController.text = euro.toStringAsFixed(2);
    }
  }

  convertEuroToUsd() {
    String input = euroController.text;
    if (input.isNotEmpty) {
      double euro = double.parse(input);
      double usd = euro * euroToUsd;
      usdController.text = usd.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                TextField(
                  controller: usdController,
                  decoration: InputDecoration(labelText: 'USD'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: convertUsdToEuro,
                  child: Text('Convert USD to EURO'),
                ),
              ],
            ),
            Row(
              children: [
                TextField(
                  controller: euroController,
                  decoration: InputDecoration(labelText: 'EURO'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: convertEuroToUsd,
                  child: Text('Convert EURO to USD'),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}