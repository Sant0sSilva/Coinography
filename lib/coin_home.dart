import 'package:coinography/models/coin_api.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/fetch_coin_data.dart';

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
      print('Error fetching coin data: $e');
      setState(() {
        _isLoading =false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( _isLoading ? 'Loading...':
          '${widget.coin.coinTitle[0].toUpperCase() + widget.coin.coinTitle.substring(1)}(${_coinData?.symbol.toUpperCase() ?? ''})',
        ),
      ),
      body: _isLoading ? const Center(
        child: CircularProgressIndicator(),
      )
      : _coinData == null ? const Center(
        child: Text('Failed to load data'),
      )
      : _buildContent(),
    );
    }

      Widget _buildContent() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 300,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      );
  }
}