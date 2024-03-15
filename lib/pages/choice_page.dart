import 'package:flutter/material.dart';
import 'package:match_it/classes/card_data.dart';
import 'package:match_it/widgets/card_widget.dart';

class ChoicePage extends StatelessWidget {
  const ChoicePage({super.key, required this.choice});

  final CardData choice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Card Chosen!"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Excellent choice everyone!",
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
              Expanded(child: CardWidget(cardData: choice)),
            ],
          ),
        ),
      ),
    );
  }
}
