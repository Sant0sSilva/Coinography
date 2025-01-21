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
  });
  final Map<String, CoinAPI> coinData;
  final List<UserCoin> coins;
  final void Function(UserCoin coin) onRemoveCoin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyPieChart(coins: coins, coinData: coinData,),
        Expanded(
          ///TODO: Conditionally render with futurebuilder //////
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
                onRemoveCoin(coins[index],);
              },
            ),
          ),
        ),
      ],
    );
  }
}
