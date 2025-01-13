import 'package:coinography/models/coin_api.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/fetch_coin_data.dart';

/*
you need to show the title of the coin in the appbar,
 - historical price graph.
 - information on the users
   holdings(price, how much their holdings are worth, and price changes.
 - Alert for price target.
 - ROI calculator
 */

class CoinHome extends StatefulWidget {
  const CoinHome({super.key, required this.coin});

  final UserCoin coin;

  @override
  State<CoinHome> createState() {
    return _CoinHomeState();
  }
}

class _CoinHomeState extends State<CoinHome> {

  CoinAPI? _coinData;


  @override
  void initState(){
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await fetchCoinData(widget.coin.coinTitle);
    setState(() {
      _coinData = data;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.coinTitle),
      ),
      body: Column(
        children: [
          Text('${_coinData?.symbol}'),
          Text('${_coinData?.currentPrice}'),
          Text('Price'),
        ],
      ),
    );
  }
}
