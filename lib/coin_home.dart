import 'package:coinography/models/coin_api.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/api_callers/fetch_coin_data.dart';

/*
you need to show the title of the coin in the appbar,
 - historical price graph.
 - information on the users
   holdings(price, how much their holdings are worth, and price changes.
 - Alert for price target.
 - ROI calculator
 */

class CoinHome extends StatefulWidget {
  const CoinHome({super.key, required this.coin});

  final UserCoin coin;

  @override
  State<CoinHome> createState() {
    return _CoinHomeState();
  }
}

class _CoinHomeState extends State<CoinHome> {
  CoinAPI? _coinData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await fetchCoinData(widget.coin.coinTitle);
      setState(() {
        _coinData = data;
        _isLoading = false;
      });
    } catch (e) {
      Text(
        'Error fetching coin data: $e',
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLoading
              ? 'Loading...'
              : '${widget.coin.coinTitle[0].toUpperCase() + widget.coin.coinTitle.substring(1)}(${_coinData?.symbol.toUpperCase() ?? ''})',
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _coinData == null
              ? const Center(
                  child: Text(
                    'Failed to load data',
                  ),
                )
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.network(
              _coinData!.image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${_coinData?.id[0].toUpperCase()}'
              '${_coinData?.id.substring(1)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 1),
          child: Row(
            children: [
              Text(
                '\$${_coinData?.currentPrice.toStringAsFixed(2)}',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 1, 10, 1),
          child: Row(
            children: [
              Text(
                '${_coinData?.priceChange24Percentage}% ',
                style: TextStyle(
                  color: (_coinData?.priceChange24Percentage ?? 0) > 0
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Card(
            margin: const EdgeInsets.all(16),
            elevation: 10,
            shadowColor: Colors.blueAccent,
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
                    children: [
                      const Text(
                        'Market cap rank',
                      ),
                      const Spacer(),
                      Text(
                        '#${_coinData?.marketCapRank.toString()}',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Market cap',
                      ),
                      const Spacer(),
                      Text(
                        '\$${(_coinData!.marketCap / 1000000000).toStringAsFixed(2)}B',
                      ), //make dynamic
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        '24h Trading volume',
                      ),
                      const Spacer(),
                      Text(
                        '\$${(_coinData!.totalVolume / 1000000000).toStringAsFixed(2)}B',
                        style: TextStyle(),
                      ), //make dynamic
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        '24h high',
                      ),
                      const Spacer(),
                      Text(
                        '\$${_coinData?.high24}',
                      ), //make dynamic
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        '24h Low',
                      ),
                      const Spacer(),
                      Text(
                        '\$${_coinData?.low24}',
                      ), //make dynamic
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
