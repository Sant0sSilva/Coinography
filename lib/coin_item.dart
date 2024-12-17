import 'package:coinography/coins.dart';
import 'package:flutter/material.dart';
import 'coin.dart';
import 'coin.dart';
import 'coins_list.dart';

// coinCard must display coinTitle, coinPrice, coin24h, holdings

class CoinItem extends StatelessWidget {
  const CoinItem(this.coin, {super.key});

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Text(coin.coinTitle),
      ),
    );
  }
}

//something
