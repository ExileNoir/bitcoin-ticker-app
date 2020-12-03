import 'dart:convert';

import 'package:http/http.dart' as http;

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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const kBitcoin = '1 BTC';
const kEthereum = '1 ETH';
const kLitecoin = '1 LTC';

const kCoinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const kApiKey = '66228DAC-FB45-48DE-B57F-DA3687ED3AF8';

class CoinData {
  CoinData();

  Future getCoinData(final String selectedCurrency) async {
    final Map<String, String> _headers = {'X-CoinAPI-Key': kApiKey};
    Map<String, String> _cryptoCurrencies = {};

    for (final String crypto in cryptoList) {
      final http.Response _response = await http
          .get(kCoinAPIURL + '/$crypto/$selectedCurrency', headers: _headers);

      if (_response.statusCode == 200) {
        var _dataResponse = jsonDecode(_response.body);
        final double _currency = _dataResponse['rate'];
        _cryptoCurrencies[crypto] = _currency.toStringAsFixed(0);
      } else {
        print(_response.statusCode);
        throw 'Problem with the get Request';
      }
    }
    return _cryptoCurrencies;
  }
}
