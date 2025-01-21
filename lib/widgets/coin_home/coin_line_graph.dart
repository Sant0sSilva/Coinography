import 'package:flutter/material.dart';
import 'package:coinography/models/coin_api.dart';
import 'package:fl_chart/fl_chart.dart';

class CoinLineGraph extends StatelessWidget{
  final CoinAPI? coinData;

 const CoinLineGraph({super.key, required this.coinData});

  @override
  Widget build(BuildContext context) {
    if(coinData == null){
      return const Center(child: Text('Failed to load graph data'),);
    }
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: LineChart(
        LineChartData(maxY: 60, maxX: 80),
      ),
    );

  }
}