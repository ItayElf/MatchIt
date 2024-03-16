import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/classes/card_data.dart';

const CardCollection foodCollection = CardCollection(
  name: "Test Collection",
  cards: [
    CardData(
      name: "Pizza 🍕",
      description: "This pizza is delicious!",
      imageUrl:
          "https://images.unsplash.com/photo-1638981400474-c33eeb1d27a8?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ),
    CardData(
      name: "Burger 🍔",
      description: "This burger is more delicious!",
      imageUrl:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ),
    CardData(
      name: "Sushi 🍣",
      description: "This sushi is not so good...",
    ),
    CardData(
      name: "Pancakes 🥞",
      description: "Who even eats pancakes?",
      imageUrl:
          "https://images.unsplash.com/photo-1528207776546-365bb710ee93?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ),
  ],
);
