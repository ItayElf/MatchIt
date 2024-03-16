import 'package:flutter/material.dart';
import 'package:match_it/classes/card_collection.dart';

class CollectionTile extends StatelessWidget {
  const CollectionTile({super.key, required this.collection, this.onClick});

  final CardCollection collection;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(collection.name),
        subtitle: Text("${collection.cards.length} cards"),
        onTap: onClick,
        leading: Icon(
          Icons.library_books,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
