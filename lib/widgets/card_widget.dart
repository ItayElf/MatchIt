import 'package:flutter/material.dart';
import 'package:match_it/classes/card_data.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.cardData});

  final CardData cardData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      cardData.name,
                      style: const TextStyle(fontSize: 96),
                    ),
                  ),
                  if (cardData.description != null)
                    Text(
                      cardData.description!,
                      style:
                          const TextStyle(fontSize: 28, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
