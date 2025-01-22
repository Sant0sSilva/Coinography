import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/widgets/coin_card_home/coin_card_home.dart';
import 'package:coinography/models/coin_api.dart';

//TODO: make it so you can get a dollar cost per average on adding the same coin.
///Coin card object

class CoinCard extends StatefulWidget {
  const CoinCard(this.coin, this.coinData, {super.key});

  final Map<String, CoinAPI> coinData;
  final UserCoin coin;



@override
  State<CoinCard> createState() {
    return _CoinCardState();
  }

}

class _CoinCardState extends State<CoinCard> {

double? calculatedProfitLoss;

  @override
  void initState() {
    super.initState();
    _calculateProfitLoss();
  }

    void _calculateProfitLoss() {
      final CoinAPI? data = widget.coinData[widget.coin.coinTitle];
      if (data != null) {
        setState(() {
          calculatedProfitLoss = (widget.coin.amountUSD / widget.coin.tokenAmount) *
              data.currentPrice -
              widget.coin.amountUSD;
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    final CoinAPI? data = widget.coinData[widget.coin.coinTitle];

    if (data == null) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Data not available for ${widget.coin.coinTitle}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(35.0),
      splashColor: Colors.blueAccent,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => CoinHome(coin: widget.coin),
          ),
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 6, 6, 50),
        shadowColor: Colors.lightBlueAccent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
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
                  Image.network(
                    data.image ?? 'https://placeholder.com/25', /// Lies, it can be null
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.coin.coinTitle[0].toUpperCase() +
                        widget.coin.coinTitle.substring(1).toLowerCase(),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    'Holding: \$${(calculatedProfitLoss! + widget.coin.amountUSD)
                        .toStringAsFixed(2)}' ?? 'N/A',
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'price: \$${data.currentPrice.toStringAsFixed(2)}',
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text('P/L:'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '\$${calculatedProfitLoss?.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: (calculatedProfitLoss ?? 0) > 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Text('24h:'),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${data.priceChange24Percentage.toStringAsFixed(2)}%',
                        style: TextStyle(
                            color: (data.priceChange24Percentage ?? 0) > 0
                                ? Colors.green
                                : Colors.red),
                      ),
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