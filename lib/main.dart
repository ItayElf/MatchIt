import 'package:flutter/material.dart';
import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/classes/card_data.dart';
import 'package:match_it/pages/swipe_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const CardCollection collection = CardCollection(
    name: "Test Collection",
    cards: [
      CardData(name: "Test Card 🍕", description: "This pizza is delicious!"),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatchIt!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: SwipePage(
        collection: collection,
      ),
    );
  }
}
