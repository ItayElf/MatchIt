import 'package:flutter/material.dart';
import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/classes/card_data.dart';
import 'package:match_it/widgets/card_widget.dart';
import 'package:swipe_cards/swipe_cards.dart';

// ignore: must_be_immutable
class SwipePage extends StatefulWidget {
  const SwipePage({super.key, required this.collection});

  final CardCollection collection;

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  late List<SwipeItem> _swipeItems;
  bool isFinished = false;

  void onLike(CardData cardData) {
    debugPrint("Liked: $cardData");
  }

  @override
  void initState() {
    super.initState();
    _swipeItems = widget.collection.cards
        .map((card) => SwipeItem(content: card, likeAction: () => onLike(card)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final matchEngine = MatchEngine(swipeItems: _swipeItems);

    final Widget body;
    if (isFinished) {
      body = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.hourglass_empty,
              size: 72,
              color: Colors.black54,
            ),
            Text(
              "You are done!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                color: Colors.black54,
              ),
            ),
            Text(
              "Waiting for your friends to decide...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            )
          ],
        ),
      );
    } else {
      body = Column(
        children: [
          Expanded(
            child: SwipeCards(
              matchEngine: matchEngine,
              itemBuilder: (context, index) => CardWidget(
                cardData: _swipeItems[index].content,
              ),
              onStackFinished: () {
                setState(() {
                  isFinished = true;
                });
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.collection.name),
        centerTitle: true,
      ),
      body: body,
    );
  }
}
