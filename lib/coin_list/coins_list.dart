import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/coin_list/coin_card.dart';


class CoinsList extends StatelessWidget {
  const CoinsList({
    super.key,
    required this.coins,
    required this.onRemoveCoin,
  });

  final List<UserCoin> coins;
  final void Function(UserCoin coin) onRemoveCoin;


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
