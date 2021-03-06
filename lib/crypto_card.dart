import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String bitCoinValue;
  final String selectedCurrency;
  final String coin;

  CryptoCard({this.bitCoinValue, this.selectedCurrency, this.coin});

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
            '$coin = $bitCoinValue $selectedCurrency',
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
