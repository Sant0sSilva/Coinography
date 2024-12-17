import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'coins.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.lightBlue);

void main() {

  runApp(
     MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
      ),
      home: const Coins(),
    ),
  );
}
