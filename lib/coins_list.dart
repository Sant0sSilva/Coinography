import 'package:flutter/material.dart';
import 'coin.dart';
import 'coin_card.dart';
import 'coins.dart';

class CoinsList extends StatelessWidget {
  const CoinsList({
    super.key,
    required this.coins,
    required this.onRemoveCoin,
  });

  final List<Coin> coins;
  final void Function(Coin coin) onRemoveCoin;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
          coins[index],
        ),
        child: CoinItem(
          coins[index],
        ),
        onDismissed: (direction) {
          onRemoveCoin(coins[index]);
        },
      ),
    );
  }
}
