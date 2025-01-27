
import 'package:uuid/uuid.dart';

///This object is used to capture user input from addNewCoin modal.
const uuid = Uuid();//Generates unique ID

class UserCoin {
  UserCoin({
    required this.coinTitle,
    required this.amountUSD,
    required this.tokenAmount,
  }): id = uuid.v4();

  final String id;
  final String coinTitle; //name of coin/token
  final double amountUSD; //x amount of currency exchanged for y amount of coin
  final double tokenAmount; //current Price of coin in usd

  Map<String, dynamic> toJson() => {
    'coinTitle': coinTitle,
    'amountUSD': amountUSD,
    'tokenAmount': tokenAmount,
  };

  factory UserCoin.fromJson(Map<String, dynamic> json) => UserCoin(
    coinTitle: json['coinTitle'],
    amountUSD: json['amountUSD'],
    tokenAmount: json['tokenAmount'],
  );
}

