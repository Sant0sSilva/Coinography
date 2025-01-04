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
        child: Column(
          children: [
            Text(coin.coinTitle),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text('\$${coin.amountUSD.toStringAsFixed(2)}',),
                const Spacer(),
                Row(
                  children: [
                    Text('\$${coin.tokenAmount.toStringAsFixed(2)}  ',),
                    // const Spacer(),
                    // Text('${coin.coin24H.toStringAsFixed(2)}%'),

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//something
