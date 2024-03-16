import 'package:flutter/material.dart';
import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/network/client.dart';
import 'package:match_it/pages/choice_page.dart';
import 'package:match_it/pages/swipe_page.dart';

class ClientSwipePage extends StatelessWidget {
  const ClientSwipePage({
    super.key,
    required this.collection,
    required this.client,
  });

  final CardCollection collection;
  final Client client;

  @override
  Widget build(BuildContext context) {
    client.onFinalChoice(
      (cardData) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ChoicePage(choice: cardData)),
      ),
    );

    return SwipePage(
      collection: collection,
      onLike: (card) => client.sendLikedCard(card),
    );
  }
}
