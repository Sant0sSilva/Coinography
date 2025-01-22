import 'package:coinography/models/coin_api.dart';
import 'package:coinography/widgets/new_coin.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';
import 'package:coinography/widgets//coin_list/coins_list.dart';
import 'package:coinography/api_callers/fetch_coin_data.dart';

///This object manages the state of the main page and coin cards

class Coins extends StatefulWidget {
  const Coins({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoinsState();
  }
}

class _CoinsState extends State<Coins> {
  Map<String, CoinAPI>? _coinData = {};
  bool _isLoading = true;
  double? calculatedProfitLoss;

  final List<UserCoin> _registeredCoins = [
    UserCoin(coinTitle: 'ripple', amountUSD: 10000, tokenAmount: 0.59),
    UserCoin(coinTitle: 'bitcoin', amountUSD: 10000, tokenAmount: 58314.48),
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  ///Fetch coin data //////////////////////////////////
  Future<void> _fetchData({String? coinTitle}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (coinTitle != null) {
        final CoinAPI data = await fetchCoinData(coinTitle.toLowerCase());

        setState(() {
          _coinData?[coinTitle.toLowerCase()] = data;
          _isLoading = false;
        });
      } else {
        final Map<String, CoinAPI> fetchedData = {};
        for (final coin in _registeredCoins) {
          final data = await fetchCoinData(coin.coinTitle);
          fetchedData[coin.coinTitle.toLowerCase()] = data;
        }
        setState(() {
          _coinData = fetchedData;
          _isLoading = false;
        });
      }
    } catch (e) {
      Text('Error fetching coin data $e');
    }
  }

  /// ///////////////////////////////////////
  void _addCoin(UserCoin coin) async {
    setState(() {
      _registeredCoins.add(coin);
    });

    /// Fetches Data for new coin added otherwise it would return null
    _fetchData(coinTitle: coin.coinTitle);
  }

  void _removeCoin(UserCoin coin) {
    final coinIndex = _registeredCoins.indexOf(coin);

    setState(() {
      _registeredCoins.remove(coin);
      _coinData?.remove(coin.coinTitle);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 5,
        ),
        content: const Text(
          'Coin deleted',
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredCoins.insert(coinIndex, coin);
            });
            _fetchData();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return  Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 4, 40, 188),
                  Color.fromARGB(255, 1, 1, 14),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,),),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    Widget activeScreen = const Center(
      child: Text('No coins found! Get cracking!'),
    );

    if (_registeredCoins.isNotEmpty) {
      activeScreen = CoinsList(
        coins: _registeredCoins,
        coinData: _coinData!,
        onRefresh: _fetchData,
        onRemoveCoin: _removeCoin,
      );
    }
    void _openAddCoinOverlay() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewCoin(onAddNewCoin: _addCoin),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coinographic portfolio tracker'),
        actions: [
          IconButton(
              onPressed: _openAddCoinOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 9, 33, 209),
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
        child: Column(
          children: [
            Expanded(
              child: activeScreen,
            ),
          ],
        ),
      ),
    );
  }
}
