import 'package:coinography/models/user_coin.dart';
import 'package:flutter/material.dart';
import 'package:coinography/models/coin_api.dart';

class ROICalculator extends StatefulWidget {
  const ROICalculator({required this.coinData, required this.coin, super.key});

  final CoinAPI? coinData;
  final UserCoin coin;

  @override
  State<ROICalculator> createState() {
    return _ROICalculatorState();
  }
}

class _ROICalculatorState extends State<ROICalculator> {
  final _amountController = TextEditingController();
  double? _roiResult;

  void _calculateROI(String userInput) {
    if (widget.coinData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coin data is not available')),
      );
      return;
    }

    double? enteredPrice = double.tryParse(userInput);

    if (enteredPrice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
      return;
    }

    double holdingAmount = ((widget.coin.amountUSD / widget.coin.tokenAmount) * enteredPrice);

    double roi = holdingAmount;

    setState(() {
      _roiResult = roi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Card(
        color: const Color.fromARGB(255, 6, 6, 50),
        margin: const EdgeInsets.all(16),
        elevation: 10,
        shadowColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'If the price goes up to:',
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    // width: 40,
                    // height: 20,
                    child: SizedBox(
                      height: 35,
                      width: 10,
                      child: TextField(
                        onSubmitted: _calculateROI,
                        controller: _amountController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              100.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent.withAlpha(
                                25,
                              ),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent.withAlpha(
                                200,
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          prefixText: '\$',
                          // label: Text('amount'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    'Your position will be worth: \$${_roiResult?.toStringAsFixed(2) ?? ' '}',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
