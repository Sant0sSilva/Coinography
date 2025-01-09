import 'package:flutter/material.dart';
import '../models/coin.dart';

class CoinHome extends StatefulWidget {
  const CoinHome({super.key, required this.coin});

  final Coin coin;

  @override
  State<CoinHome> createState() {
    return _CoinHomeState();
  }
}

class _CoinHomeState extends State<CoinHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'HELLO',
        ),
      ],
    );
  }
}
