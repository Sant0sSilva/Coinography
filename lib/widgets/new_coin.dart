import 'package:flutter/material.dart';
import 'package:coinography/models/user_coin.dart';

///This object manages the add new coin modal and user data input.

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

  final _coinTitleFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _tokenFocusNode = FocusNode();

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
          backgroundColor: Colors.grey.shade700,
          title: const Text('Invalid input!', style: TextStyle(color: Colors.black),),
          content: const Text(
            'Please enter a valid Title, amount and tokens bought',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddNewCoin(
      UserCoin(
          coinTitle: _coinTitleController.text.toLowerCase(),
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
    _coinTitleFocusNode.dispose();
    _tokenFocusNode.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  //Decorations for add coin modal overlay
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _coinTitleController,
                    focusNode: _coinTitleFocusNode,
                    decoration: const InputDecoration(
                      label: Text('Coin "ID"(example: ethereum)'),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_amountFocusNode);
                    },
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    focusNode: _amountFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$ ',
                      label: Text('Amount(USD)'),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_tokenFocusNode);
                    },
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
                    focusNode: _tokenFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$ ',
                      label: Text('Token price(USD)'),
                    ),
                    onEditingComplete: () {
                      _submitCoinData();
                    },
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
      ),
    );
  }
}
