import 'package:flutter/material.dart';
import 'coin.dart';

// coinCard must display coinTitle, coinPrice, coin24h, holdings, profit/loss.

class CoinItem extends StatelessWidget {
  const CoinItem(this.coin, {super.key});

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(35.0),
      splashColor: Colors.blueAccent.withOpacity(0.2),
      onTap: () {
        print('tap tap');
      },
      child: Card(
        shadowColor: Colors.blueAccent,
        elevation: 10,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35.0),),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/coin_icons/${coin.coinTitle.toLowerCase()}.png',
                    height: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(coin.coinTitle),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    'Holding: \$${coin.amountUSD.toStringAsFixed(2)}',
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'price: \$${coin.tokenAmount.toStringAsFixed(2)}  ',
                      ),
                      // const Spacer(),
                      // Text('${coin.coin24H.toStringAsFixed(2)}%'),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text('P/L: 0'),
                  const Spacer(),
                  Row(
                    children: [
                      Text('24h: 0'),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//something
