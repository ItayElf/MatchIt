import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/classes/card_data.dart';
import 'package:match_it/network/server.dart';
import 'package:match_it/pages/choice_page.dart';
import 'package:match_it/pages/swipe_page.dart';

class ServerSwipePage extends StatefulWidget {
  const ServerSwipePage({
    super.key,
    required this.collection,
    required this.server,
  });

  final CardCollection collection;
  final Server server;

  @override
  State<ServerSwipePage> createState() => _ServerSwipePageState();
}

class _ServerSwipePageState extends State<ServerSwipePage> {
  final Map<CardData, int> likedCards = {};
  late int connections;

  @override
  void initState() {
    super.initState();
    widget.server.onJoin(null);
    connections =
        widget.server.sockets.length + 1; // Plus one for the server itself
  }

  CardData? getWinner() {
    for (final entry in likedCards.entries) {
      if (entry.value == connections) return entry.key;
    }
    return null;
  }

  void onAddedCard(BuildContext context, CardData cardData) {
    final count = likedCards[cardData] ?? 0;
    likedCards[cardData] = count + 1;
    handleAddedCard(context);
  }

  Future handleAddedCard(BuildContext context) async {
    final winner = getWinner();
    if (winner == null) return;
    debugPrint("Winner: $winner");
    likedCards.clear();
    await widget.server.broadcastChoice(winner);
    await widget.server.stop();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ChoicePage(choice: winner)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.server.onError(
      (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
        debugPrint("ERROR: $error");
        debugPrintStack();
      },
    );

    widget.server.onLikedCard(
      (cardData) => onAddedCard(context, cardData),
    );

    return SwipePage(
      collection: widget.collection,
      onLike: (card) => onAddedCard(context, card),
    );
  }
}
