import 'package:coinography/models/coin_api.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/api_callers/fetch_coin_data.dart';
import 'package:coinography/widgets//coin_home/coin_line_graph.dart';
import 'package:coinography/widgets/coin_home/coin_stat_card.dart';
import 'package:coinography/widgets/coin_home/coin_home_header_price.dart';

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
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _coinData == null
              ? const Center(
                  child: Text('Failed to load data'),
                )
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    if(_coinData == null){
      return const Center(child: Text('Failed to load content'),);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          /// Header and image /////////////////////////
          children: [
            Image.network(
              _coinData!.image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 5),
            Text(
              /// Header  /////
              '${_coinData?.id[0].toUpperCase()}${_coinData?.id.substring(1)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )
          ],
        ),
        /// Current price and 24 change in percent ////
        CoinHomeHeaderPrice(coinData: _coinData),
        ///Line graph ////////////////////////////////////////////
        CoinLineGraph(coinData: _coinData),
        /// Currency stats card //////////////////////////////
        CoinStatCard(coinData: _coinData),
      ],
    );
  }
}
