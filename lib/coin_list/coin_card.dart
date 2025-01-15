
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/coin_home.dart';
import 'package:coinography/models/coin_api.dart';
import 'package:coinography/api_callers/fetch_coin_data.dart';

class CoinItem extends StatefulWidget {
  const CoinItem(this.coin, {super.key});

  final UserCoin coin;

  @override
  State<CoinItem> createState() {
    return _CoinItemState();
  }
}

class _CoinItemState extends State<CoinItem> {
  CoinAPI? _coinData;
  bool _isLoading = true;
  double? calculatedProfitLoss;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _calculateProfitLoss() {
    if (_coinData != null) {
      calculatedProfitLoss = profitLossCalculator(
        widget.coin.amountUSD,
        widget.coin.tokenAmount,
        _coinData!.currentPrice,
      );
    }
  }

  Future<void> _fetchData() async {
    try {
      final data = await fetchCoinData(widget.coin.coinTitle);
      setState(() {
        _coinData = data;
        _isLoading = false;
        _calculateProfitLoss();
      });

    } catch (e) {
      Text('error fetching coin data: $e');
      setState(() {
        _isLoading = false;
      });

    }
  }

  double profitLossCalculator(
      double amountUSD, double tokenAmount, double currentPrice) {
    return (amountUSD / tokenAmount) * currentPrice - amountUSD;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const
      Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_coinData == null) {
      return const Center(
        child: Text('Failed to load coin data'),
      );
    }


    return InkWell(
      borderRadius: BorderRadius.circular(35.0),
      splashColor: Colors.blueAccent.withOpacity(0.2),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => CoinHome(coin: widget.coin),
          ),
        );
      },
      child: Card(
        shadowColor: Colors.blueAccent,
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
                    _coinData?.image ?? 'https://placeholder.com/25',
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Text(widget.coin.coinTitle),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    'Holding: \$${(calculatedProfitLoss! + widget.coin.amountUSD).toStringAsFixed(2)}',
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'price: \$${_coinData?.currentPrice.toStringAsFixed(2)}  ',
                      ),
                      // const Spacer(),
                      // Text('${coin.coin24H.toStringAsFixed(2)}%'),
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
                    '${calculatedProfitLoss?.toStringAsFixed(2)}',
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
                        '${_coinData?.priceChange24Percentage.toStringAsFixed(2)}%',
                        style: TextStyle(
                            color: (_coinData?.priceChange24Percentage ?? 0) > 0
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