import 'package:flutter/material.dart';
import 'coin.dart';
import 'coin_item.dart';

class CoinsList extends StatelessWidget {
  const CoinsList({super.key, required this.coins, });

  final List<Coin> coins;
  // final void Function(Coin coin) onRemoveCoin;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (ctx, index) => CoinItem(coins[index],),
    );
  }
}
