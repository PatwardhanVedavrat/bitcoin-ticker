import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  PriceScreen({this.btc, this.eth, this.ltc});
  final btc;
  final eth;
  final ltc;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  void initState() {
    super.initState();
    getRate(btc: widget.btc, eth: widget.eth, ltc: widget.ltc);
  }

  String initialValue = 'INR';
  var btcRate;
  var ethRate;
  var ltcRate;
  void getRate({var btc, var eth, var ltc}) {
    setState(() {
      btcRate = btc;
      ethRate = eth;
      ltcRate = ltc;
    });
  }

  Widget androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      value: initialValue,
      items: dropdownItems,
      onChanged: (String newValue) async {
        initialValue = newValue;
        var newData =
            await CoinData().getData(currency: newValue, crypto: 'BTC');
        var btc = newData['rate'].toStringAsFixed(2);
        newData = await CoinData().getData(currency: newValue, crypto: 'ETH');
        var eth = newData['rate'].toStringAsFixed(2);
        newData = await CoinData().getData(currency: newValue, crypto: 'LTC');
        var ltc = newData['rate'].toStringAsFixed(2);
        setState(() {
          getRate(btc: btc, eth: eth, ltc: ltc);
        });
      },
    );
  }

  Widget iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 40.0,
      onSelectedItemChanged: (selectedItem) async {
        initialValue = pickerItems[selectedItem].data;
        var newData =
            await CoinData().getData(currency: initialValue, crypto: 'BTC');
        var btc = newData['rate'].toStringAsFixed(2);
        newData =
            await CoinData().getData(currency: initialValue, crypto: 'ETH');
        var eth = newData['rate'].toStringAsFixed(2);
        newData =
            await CoinData().getData(currency: initialValue, crypto: 'LTC');
        var ltc = newData['rate'].toStringAsFixed(2);
        setState(() {
          getRate(btc: btc, eth: eth, ltc: ltc);
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DisplayWidget(
              crypto: 'BTC', rate: btcRate, initialValue: initialValue),
          DisplayWidget(
              crypto: 'ETH', rate: ethRate, initialValue: initialValue),
          DisplayWidget(
              crypto: 'LTC', rate: ltcRate, initialValue: initialValue),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({
    @required this.rate,
    @required this.initialValue,
    @required this.crypto,
  });

  final rate;
  final initialValue;
  final crypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $rate $initialValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
