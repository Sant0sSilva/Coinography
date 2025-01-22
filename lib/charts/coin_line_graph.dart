import 'package:flutter/material.dart';
import 'package:coinography/models/coin_api.dart';
import 'package:fl_chart/fl_chart.dart';

class CoinLineGraph extends StatelessWidget {
  final CoinAPI? coinData;

//https://api.coingecko.com/api/v3/coins/ripple/market_chart?vs_currency=usd&days=30
  const CoinLineGraph({super.key, required this.coinData});

  @override
  Widget build(BuildContext context) {
    final spots = [
      FlSpot(0, 3.17),
      FlSpot(1, 5.13),
      FlSpot(2, 7.84),
      FlSpot(3, 12.32),
      FlSpot(4, 18.62),
      FlSpot(5, 13.14),
      FlSpot(6, 16.72),
      FlSpot(7, 17.52),
      FlSpot(8, 21.97),
      FlSpot(9, 29.45),
      FlSpot(10, 22.43),
      FlSpot(11, 30.60),
      FlSpot(12, 19.11),
      FlSpot(13, 27.07),
      FlSpot(14, 18.71),
    ];

    final minX = spots.first.x;
    final maxX = spots.last.x;
    final miny = spots.map((e) => e.y).reduce((a, b) => a < b? a : b);
    final maxy = spots.map((e) => e.y).reduce((a, b) => a > b? a : b);


    return AspectRatio(
      aspectRatio: 2,
      // width: double.infinity,
      // height: 250,
      child: LineChart(
        LineChartData(
            minX: minX,
            maxX: maxX,
            minY: miny,
            maxY: maxy,
            gridData: const FlGridData(
              show: false,
            ),
            borderData: FlBorderData(
              show: false,
            ),
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                  curveSmoothness: 0.5,
                  isCurved: true,
                  belowBarData: BarAreaData(
                    show: true,
                  ),
                  dotData: const FlDotData(
                    show: false,
                  ),
                  spots: spots,)
            ]),
      ),
    );
  }
}
