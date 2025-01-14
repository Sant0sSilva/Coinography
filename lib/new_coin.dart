import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';

class NewCoin extends StatefulWidget {
  const NewCoin({super.key, required this.onAddNewCoin});

  final void Function(UserCoin coin) onAddNewCoin;

  @override
  State<NewCoin> createState() {
    return _NewCoinState();
  }
}

class _NewCoinState extends State<NewCoin> {
  final _coinTitleController = TextEditingController();
  final _amountController = TextEditingController();
  final _tokenAmount = TextEditingController();


  void _submitCoinData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final enteredToken = double.tryParse(_tokenAmount.text);

    final amountAndTokenIsInvalid = enteredAmount == null ||
        enteredAmount <= 0 ||
        enteredToken == null ||
        enteredToken <= 0;
    if (_coinTitleController.text.trim().isEmpty || amountAndTokenIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input!'),
          content: const Text(
              'Please enter a valid Title, amount and tokens bought'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddNewCoin(
      UserCoin(
          coinTitle: _coinTitleController.text,
          amountUSD: enteredAmount,
          tokenAmount: enteredToken),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _coinTitleController.dispose();
    _amountController.dispose();
    _tokenAmount.dispose();
    super.dispose();
  }

  //Decorations for add coin modal overlay
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _coinTitleController,
                  decoration: const InputDecoration(
                    label: Text('Coin "ID"'),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount(USD)'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _tokenAmount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Token price'),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitCoinData,
                child: const Text('Save coin'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
