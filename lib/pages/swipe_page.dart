import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/classes/card_data.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({super.key, required this.collection});

  final CardCollection collection;

  void onLike(CardData cardData) {
    debugPrint("Liked: $cardData");
  }

  List<SwipeItem> getSwipeItems() => collection.cards
      .map((card) => SwipeItem(content: card, likeAction: () => onLike(card)))
      .toList();

  @override
  Widget build(BuildContext context) {
    final swipeItems = getSwipeItems();
    final matchEngine = MatchEngine(swipeItems: swipeItems);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(collection.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SwipeCards(
              matchEngine: matchEngine,
              itemBuilder: (context, index) => Container(
                color: Colors.red,
                height: 200,
                width: 200,
              ),
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Stack Finished"),
                  duration: Duration(milliseconds: 500),
                ));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: matchEngine.currentItem?.nope,
                child: const Icon(Icons.cancel),
              ),
              ElevatedButton(
                onPressed: matchEngine.currentItem?.like,
                child: const Icon(Icons.favorite),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
