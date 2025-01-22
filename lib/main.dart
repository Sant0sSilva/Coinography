import 'package:flutter/material.dart';
import 'coins.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blueAccent,
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.white,)
        ),
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
