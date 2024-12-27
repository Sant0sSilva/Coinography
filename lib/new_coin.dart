import 'package:flutter/material.dart';

class NewCoin extends StatefulWidget {
  const NewCoin({super.key});

  @override
  State<NewCoin> createState() {
    return _NewCoin();
  }
}

class _NewCoin extends State<NewCoin> {
  final _coinTitleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _coinTitleController.dispose();
    super.dispose();
  }

  var _enteredCoinTitle = '';

  void _saveCoinTitle(String inputValue) {
    _enteredCoinTitle = inputValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        children: [
          TextField(
            controller: _coinTitleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Coin'),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_coinTitleController.text);
                },
                child: const Text('Save coin'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
