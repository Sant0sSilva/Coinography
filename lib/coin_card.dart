import 'package:flutter/material.dart';
import 'coin.dart';

// coinCard must display coinTitle, coinPrice, coin24h, holdings. profit/loss

class CoinItem extends StatelessWidget {
  const CoinItem(this.coin, {super.key});

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('tap tap');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              Text(coin.coinTitle),
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
                  Text('P/L'),
                  const Spacer(),
                  Row(children: [
                    Text('24h'),
                  ],)
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
