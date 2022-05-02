import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'price_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var exchangeData = await CoinData().getData(currency: 'INR', crypto: 'BTC');
    var btc = exchangeData['rate'].toStringAsFixed(2);
    exchangeData = await CoinData().getData(currency: 'INR', crypto: 'ETH');
    var eth = exchangeData['rate'].toStringAsFixed(2);
    exchangeData = await CoinData().getData(currency: 'INR', crypto: 'LTC');
    var ltc = exchangeData['rate'].toStringAsFixed(2);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(btc: btc, eth: eth, ltc: ltc);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
