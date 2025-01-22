import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/models/coin_api.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({
    super.key,
    required this.coins,
    required this.coinData,
    required this.totalHoldings,
  });
  final double? totalHoldings;
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
      
      final double percentage = (totalHoldings! > 0) ? (holdings / totalHoldings!) * 100 : 0.0;
      
      return PieChartSectionData(
        value: holdings,
        radius: chartRadius,
        color: const Color.fromARGB(255, 29, 95, 128),
        title: '${coin.coinTitle[0].toUpperCase() + coin.coinTitle.substring(1)}: ${percentage.toStringAsFixed(2)}%',
        titleStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.lightBlueAccent,
        ),
      );
    }).toList();

    return SizedBox(
        height: 300,
        child: AspectRatio(
          aspectRatio: 1.9,
            child: PieChart(
              PieChartData(
                sections: chartSections,
                centerSpaceRadius: 100,
                sectionsSpace: 4,
              ),
            ),
          ),
      );
  }
}
