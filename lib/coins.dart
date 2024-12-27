import 'package:coinography/new_coin.dart';
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
        entryPrice: 9308,
        coinPrice: 2.48,
        coin24H: 3.87,
        holdings: 9308),
    Coin(
        coinTitle: 'BTC',
        entryPrice: 18308,
        coinPrice: 88000,
        coin24H: -4.69,
        holdings: 18308),
  ];

  void _openAddCoinOverlay() {
    showModalBottomSheet(context: context, builder: (ctx) => NewCoin());
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
