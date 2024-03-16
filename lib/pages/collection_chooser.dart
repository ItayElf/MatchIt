import 'package:flutter/material.dart';
import 'package:match_it/collections/collections_manager.dart';
import 'package:match_it/pages/host_page.dart';
import 'package:match_it/widgets/collection_tile.dart';

class CollectionChooser extends StatelessWidget {
  const CollectionChooser({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = CollectionManager.getAllCollections();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Collection Chooser"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                "Choose a collection to start:",
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, i) => CollectionTile(
                    collection: collections[i],
                    onClick: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => HostPage(collection: collections[i]),
                      ),
                    ),
                  ),
                  itemCount: collections.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
