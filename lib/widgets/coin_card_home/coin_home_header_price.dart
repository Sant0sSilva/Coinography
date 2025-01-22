import 'package:flutter/material.dart';
import 'package:coinography/models/coin_api.dart';

class CoinHomeHeaderPrice extends StatelessWidget{
  final CoinAPI? coinData;

  const CoinHomeHeaderPrice({super.key, required this.coinData});

  @override
  Widget build(BuildContext context) {
    if(coinData == null) {
      return const Center(child: Text('Failed to load data'),);
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 1),
      child: Row(
        children: [
          Text(
            /// current price.
            '\$${coinData?.currentPrice.toStringAsFixed(2)}',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 1, 10, 1),
            child: Row(
              children: [
                Text(
                  /// 24h Change in percent
                  '${coinData?.priceChange24Percentage.toStringAsFixed(2)}% ',
                  style: TextStyle(
                    color: (coinData?.priceChange24Percentage ?? 0) > 0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}