import 'package:flutter/material.dart';
import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/classes/card_data.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipePage extends StatelessWidget {
  SwipePage({super.key, required this.collection}) {
    _swipeItems = collection.cards
        .map((card) => SwipeItem(content: card, likeAction: () => onLike(card)))
        .toList();
  }

  final CardCollection collection;
  late List<SwipeItem> _swipeItems;

  void onLike(CardData cardData) {
    debugPrint("Liked: $cardData");
  }

  @override
  Widget build(BuildContext context) {
    final matchEngine = MatchEngine(swipeItems: _swipeItems);

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
