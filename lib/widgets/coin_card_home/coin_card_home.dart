import 'package:coinography/models/coin_api.dart';
import 'package:coinography/widgets/coin_card_home/roi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/api_callers/fetch_coin_data.dart';
import 'package:coinography/charts/coin_line_graph.dart';
import 'package:coinography/widgets/coin_card_home/coin_stat_card.dart';
import 'package:coinography/widgets/coin_card_home/coin_home_header_price.dart';

/// Displays coin information and stats after coin card is pressed

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

  /// Fetches additional data than is displayed on coin card
  Future<void> _fetchData() async {
    try {
      final data = await fetchCoinData(widget.coin.coinTitle);
      setState(() {
        _coinData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override

  ///APP BAR Title. ////////////////////////////////////////
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLoading
              ? 'Loading...'
              : '${widget.coin.coinTitle[0].toUpperCase() + widget.coin.coinTitle.substring(1)} (${_coinData?.symbol.toUpperCase() ?? ''})',
        ),
      ),
      body: _isLoading
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 9, 33, 209),
                    Color.fromARGB(255, 1, 1, 14),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : _coinData == null
              ? const Center(
                  child: Text('Failed to load data'),
                )
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_coinData == null) {
      return const Center(
        child: Text('Failed to load content'),
      );
    }
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 2, 13, 87),
            Color.fromARGB(255, 1, 1, 14),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          //   Color.fromARGB(255, 95, 95, 97),
          //   Color.fromARGB(255, 0, 3, 11),
          // ],
          // begin: Alignment.topCenter,
          // end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                /// Header and LOGO /////////////////////////
                children: [
                  Image.network(
                    _coinData!.image,
        
                    /// image received from API
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    /// Header  ///////////////////////
                    '${_coinData?.id[0].toUpperCase()}${_coinData?.id.substring(1)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  )
                ],
              ),
            ),
        
            /// Current price and 24h change in percent ////
            CoinHomeHeaderPrice(
              coinData: _coinData,
            ),
        
            ///Line graph ////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 1, 20, 5),
              child: CoinLineGraph(
                coinData: _coinData,
              ),
            ),
        
            /// Currency stats card //////////////////////////////
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 1, 0),
              child: Row(
                children: [
                  Text(
                    'Stats',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            CoinStatCard(
              coinData: _coinData,
            ),
        
            ///ROI calculator
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 1, 0),
              child: Row(
                children: [
                  Text(
                    'ROI Calculator',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            ROICalculator(
              coinData: _coinData,
              coin: widget.coin,
            ),
          ],
        ),
      ),
    );
  }
}
