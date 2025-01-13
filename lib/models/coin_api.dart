class CoinAPI {
  CoinAPI(
      {required this.id,
      required this.symbol,
      required this.image,
      required this.currentPrice,
      required this.high24,
      required this.low24,
      required this.priceChange24,
      required this.marketCap,
      required this.totalVolume});

  final String id;
  final String symbol;
  final String image;
  final double currentPrice;
  final double high24;
  final double low24;
  final double priceChange24;
  final double marketCap;
  final double totalVolume;

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
