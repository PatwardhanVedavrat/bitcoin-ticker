import 'networking.dart';

const apiKey = '1B455D8E-0E25-47EB-A063-7DEBB1306596';
const url = 'https://rest.coinapi.io/v1/exchangerate/BTC/INR?apikey=';

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

class CoinData {
  Future getData({String currency, String crypto}) async {
    Networking networking = Networking(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apiKey');
    var conversionData = await networking.getData();
    return conversionData;
  }
}
//rate
