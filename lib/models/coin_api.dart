class CoinAPI {
<<<<<<< Updated upstream
  CoinAPI(
      {required this.id,
      required this.symbol,
      required this.image,
      required this.currentPrice,
      required this.high24,
      required this.low24,
      required this.priceChange24Percentage,
      required this.marketCap,
      required this.totalVolume,
      required this.marketCapRank,
      });
=======
  CoinAPI({
    required this.id,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.high24,
    required this.low24,
    required this.priceChange24Percentage,
    required this.marketCap,
    required this.totalVolume,
    required this.marketCapRank,
  });
>>>>>>> Stashed changes

  final String id;
  final String symbol;
  final String image;
  final double currentPrice;
  final double high24;
  final double low24;
  final double priceChange24Percentage;
  final double marketCap;
  final double totalVolume;
<<<<<<< Updated upstream
  final int? marketCapRank;
=======
  final int marketCapRank;
>>>>>>> Stashed changes
}

/*
id
symbol
image
current_price
high_24h
low_24h
price_change_24h
market_cap
total_volume
 */
