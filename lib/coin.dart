import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();//Generates unique ID

class Coin {
  Coin({
    required this.coinTitle,
    required this.entryPrice,
    required this.coinPrice,
    required this.coin24H,
    required this.holdings,
  }): id = uuid.v4();

  final String id;
  final String coinTitle; //name of coin/token
  final double entryPrice; //x amount of currency exchanged for y amount of coin
  final double coinPrice; //current Price of coin in usd
  final double
      coin24H; // displays price change in percentage over the last day.
  final double
      holdings; // how much currency to buy coins(might be same as entryPrice)
}
