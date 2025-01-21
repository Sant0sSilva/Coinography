import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/models/coin_api.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({
    super.key,
    required this.coins,
    required this.coinData,
  });

  final List<UserCoin> coins;
  final Map<String, CoinAPI> coinData;

  /// Calculates the profit or loss
  double profitLossCalculator({
    required double amountUSD,
    required double tokenAmount,
    required double currentPrice,
  }) {
    return (amountUSD / tokenAmount) * currentPrice - amountUSD;
  }

  @override
  Widget build(BuildContext context) {
    double chartRadius = 20;


    final chartSections = coins.map((coin) {

      final CoinAPI? data = coinData[coin.coinTitle.toLowerCase()];


      final double holdings = data != null
          ? (coin.amountUSD + profitLossCalculator(
        amountUSD: coin.amountUSD,
        tokenAmount: coin.tokenAmount,
        currentPrice: data.currentPrice,
      ))
          : coin.amountUSD;

      return PieChartSectionData(
        value: holdings,
        radius: chartRadius,
        color: Colors.lightBlue,
        title: '${coin.coinTitle}: \$${holdings.toStringAsFixed(2)}',
        titleStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }).toList();

    return SizedBox(
      height: 300,
      child: AspectRatio(
        aspectRatio: 1.9,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: PieChart(
            PieChartData(
              sections: chartSections,
              centerSpaceRadius: 100,
              sectionsSpace: 4,
            ),
          ),
        ),
      ),
    );
  }
}
