import 'new_coin.dart';
import 'package:flutter/material.dart';
import 'coin.dart';
import 'coins_list.dart';


class Coins extends StatefulWidget {
  const Coins({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoinsState();
  }
}

class _CoinsState extends State<Coins> {
  final List<Coin> _fakeCoins = [
    Coin(
        coinTitle: 'XRP',
        amountUSD: 9308,
        tokenAmount: 2.48),
    Coin(
        coinTitle: 'BTC',
        amountUSD: 18308,
        tokenAmount: 88000),
  ];

  void _openAddCoinOverlay() {
    showModalBottomSheet(context: context, builder: (ctx) => NewCoin(onAddNewCoin: _addCoin),);
  }

  void _addCoin(Coin coin){
    setState(() {
      _fakeCoins.add(coin);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No coins found!'),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Coinographic portfolio tracker'),
        actions: [
          IconButton(onPressed: _openAddCoinOverlay,
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CoinsList(coins: _fakeCoins),
          ),
        ],
      ),
    );
  }
}
