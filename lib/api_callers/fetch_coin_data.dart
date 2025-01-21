import 'package:coinography/models/coin_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

///fetches live coin data from CoinGecko's API
// https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=ripple&order=market_cap_desc&per_page=1&page=1&sparkline=false

Future<CoinAPI> fetchCoinData(
  String coinTitle,
) async {
  String urlStart =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=';
  String urlEnd = '&order=market_cap_desc&per_page=1&page=1&sparkline=false';

  final response = await http.get(Uri.parse('$urlStart$coinTitle$urlEnd'));
  final jsonResponse = json.decode(response.body);
    return CoinAPI(
      id: jsonResponse[0]['id'],
      symbol: jsonResponse[0]['symbol'],
      image: jsonResponse[0]['image'],
      currentPrice: jsonResponse[0]['current_price'].toDouble(),
      high24: jsonResponse[0]['high_24h'].toDouble(),
      low24: jsonResponse[0]['low_24h'].toDouble(),
      priceChange24Percentage:
          jsonResponse[0]['price_change_percentage_24h'].toDouble(),
      marketCap: jsonResponse[0]['market_cap'].toDouble(),
      totalVolume: jsonResponse[0]['total_volume'].toDouble(),
      marketCapRank: jsonResponse[0]['market_cap_rank'] as int,
    );
}
