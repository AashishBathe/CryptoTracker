import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'YOUR_API_KEY';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'TRX', 'XRP', 'DOT'];

class CoinData {
  bool isWaiting = true;
  Future<Map> getCoinData(String? currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      Uri uri = Uri.https('rest.coinapi.io',
          '/v1/exchangerate/$crypto/$currency', {'apikey': '$apiKey'});
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        isWaiting = false;
        var data = jsonDecode(response.body);
        var price = data['rate'].toStringAsFixed(2);
        cryptoPrices[crypto] = price;
      } else {
        print(response.statusCode);
        throw 'Problem with get request';
      }
    }
    return cryptoPrices;
  }
}
