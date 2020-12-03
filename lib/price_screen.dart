import 'dart:io';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/crypto_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final CoinData _coinData = CoinData();
  String _selectedCurrency = 'USD';
  Map<String, String> _coinValues = {};
  bool _isWaiting = false;

  DropdownButton<String> _androidDropdown() {
    return DropdownButton<String>(
      value: _selectedCurrency,
      items: _getDropdownItems(),
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value;
          getData();
        });
      },
    );
  }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    final List<DropdownMenuItem<String>> dropdownItems = [];

    for (final String currency in currenciesList) {
      var dropdownItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownItems.add(dropdownItem);
    }
    return dropdownItems;
  }

  CupertinoPicker _iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          _selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: _getPickerItems(),
    );
  }

  List<Text> _getPickerItems() {
    final List<Text> pickerItems = [];

    for (final String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return pickerItems;
  }

  void getData() async {
    _isWaiting = true;
    try {
      var data = await _coinData.getCoinData(_selectedCurrency);
      _isWaiting = false;
      setState(() {
        _coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  Column makeCards() {
    final List<CryptoCard> cryptoCards = [];

    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          coin: crypto,
          selectedCurrency: _selectedCurrency,
          bitCoinValue: _isWaiting ? '?' : _coinValues[crypto],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? _androidDropdown() : _iOSPicker(),
          ),
        ],
      ),
    );
  }
}
