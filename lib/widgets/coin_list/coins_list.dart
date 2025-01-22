import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/widgets/coin_list/coin_card.dart';
import 'package:coinography/charts/pie_chart.dart';
import 'package:coinography/models/coin_api.dart';

///Displays MyPieChart and coinCard added by user to build portfolio.
class CoinsList extends StatelessWidget {
  const CoinsList({
    super.key,
    required this.coins,
    required this.coinData,
    required this.onRemoveCoin,
    required this.onRefresh,
  });
  final Map<String, CoinAPI> coinData;
  final List<UserCoin> coins;
  final void Function(UserCoin coin) onRemoveCoin;
  final Future<void> Function() onRefresh;

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
    /// Calculate holdings ///////////////////////////////
    final coinList = coins.map((coin) {
      final CoinAPI? data = coinData[coin.coinTitle.toLowerCase()];

      final double holdings = data != null
          ? (coin.amountUSD +
              profitLossCalculator(
                amountUSD: coin.amountUSD,
                tokenAmount: coin.tokenAmount,
                currentPrice: data.currentPrice,
              ))
          : coin.amountUSD;

      return holdings;
    }).toList();

    ///Calculate total holdings ///
    final double totalHoldings = coinList.reduce((a, b) => a + b);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Total: \$${totalHoldings.toStringAsFixed(2)}'),
              ),
            ],
          ),
        ),
        MyPieChart(
          coins: coins,
          coinData: coinData,
          totalHoldings: totalHoldings,
        ),
        Expanded(
          child: RefreshIndicator(
            elevation: 15,
            edgeOffset: 30,
            color: const Color.fromARGB(255, 3, 18, 198),
            backgroundColor: const Color.fromARGB(255, 1, 14, 76),
            displacement: 60,
            onRefresh: onRefresh,
            child: ListView.builder(
              itemCount: coins.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(
                  coins[index],
                ),
                child: CoinCard(
                  coins[index],
                  coinData,
                ),
                onDismissed: (direction) {
                  onRemoveCoin(
                    coins[index],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
