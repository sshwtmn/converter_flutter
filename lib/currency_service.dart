import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  Future<Map<String, double>> fetchCurrencies() async {
    var response = await http.get(Uri.parse('https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_lFcnZRfueNBn2auSZ6p2on8HInDTnRBif3ZTjH59'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      double usdToEuro = jsonData['data']['EUR'];
      double euroToUsd = 1 / usdToEuro;
      return {'usdToEuro': usdToEuro, 'euroToUsd': euroToUsd};
    } else {
      throw Exception('Failed to load currency data');
    }
  }
}