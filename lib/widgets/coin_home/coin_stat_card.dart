import 'package:flutter/material.dart';
import 'package:coinography/models/coin_api.dart';

class CoinStatCard extends StatelessWidget{
  final CoinAPI? coinData;

   const CoinStatCard({super.key, required this.coinData});

  @override
  Widget build(BuildContext context) {
    if (coinData == null){
      return const Center(child: Text('Failed to load data'),);
    }
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Card(
        color: const Color.fromARGB(255, 6, 6, 50),
        margin: const EdgeInsets.all(16),
        elevation: 10,
        shadowColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Market cap rank'),
                  const Spacer(),
                  Text('#${coinData?.marketCapRank}'),
                ],
              ),
              Row(
                children: [
                  const Text('Market cap'),
                  const Spacer(),
                  Text(
                    '\$${(coinData!.marketCap / 1000000000).toStringAsFixed(2)}B',
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('24h Trading volume'),
                  const Spacer(),
                  Text(
                    '\$${(coinData!.totalVolume / 1000000000).toStringAsFixed(2)}B',
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('24h high'),
                  const Spacer(),
                  Text('\$${coinData?.high24.toStringAsFixed(2)}'),
                ],
              ),
              Row(
                children: [
                  const Text('24h low'),
                  const Spacer(),
                  Text('\$${coinData?.low24.toStringAsFixed(2)}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}