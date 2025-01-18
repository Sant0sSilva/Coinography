import 'package:coinography/new_coin.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/coin_list/coins_list.dart';

///This object manages the state of the main page and coin cards

class Coins extends StatefulWidget {
  const Coins({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoinsState();
  }
}

class _CoinsState extends State<Coins> {
  final List<UserCoin> _registeredCoins = [
    UserCoin(coinTitle: 'ripple', amountUSD: 10000, tokenAmount: 0.59),
    UserCoin(coinTitle: 'bitcoin', amountUSD: 10000, tokenAmount: 58314.48),
  ];

  void _addCoin(UserCoin coin) {
    setState(() {
      _registeredCoins.add(coin);
    });
  }

  void _removeCoin(UserCoin coin) {
    final coinIndex = _registeredCoins.indexOf(coin);

    setState(() {
      _registeredCoins.remove(coin);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 5,
        ),
        content: const Text(
          'Coin deleted',
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
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
    void _openAddCoinOverlay() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewCoin(onAddNewCoin: _addCoin),
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
