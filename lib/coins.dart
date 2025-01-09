import 'new_coin.dart';
import 'package:flutter/material.dart';
import 'models/coin.dart';
import 'coin_list/coins_list.dart';


class Coins extends StatefulWidget {
  const Coins({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoinsState();
  }
}

class _CoinsState extends State<Coins> {
  final List<Coin> _registeredCoins = [
    Coin(coinTitle: 'XRP', amountUSD: 9308, tokenAmount: 2.48),
    Coin(coinTitle: 'BTC', amountUSD: 18308, tokenAmount: 88000),
  ];

  void _openAddCoinOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewCoin(onAddNewCoin: _addCoin),
    );
  }

  void _addCoin(Coin coin) {
    setState(() {
      _registeredCoins.add(coin);
    });
  }

  void _removeCoin(Coin coin) {
    final coinIndex = _registeredCoins.indexOf(coin);

    setState(() {
      _registeredCoins.remove(coin);
    });
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Coin deleted'),
        action: SnackBarAction(label: 'Undo', onPressed: () {
          setState(() {
            _registeredCoins.insert(coinIndex, coin);
          });
        },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const Center(
      child: Text('No coins found! Get cracking!'),
    );

    if (_registeredCoins.isNotEmpty) {
      activeScreen = CoinsList(
        coins: _registeredCoins,
        onRemoveCoin: _removeCoin,
      );
    }



    return Scaffold(
      appBar: AppBar(
        title: const Text('Coinographic portfolio tracker'),
        actions: [
          IconButton(
              onPressed: _openAddCoinOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: activeScreen,
          ),
        ],
      ),
    );
  }
}
