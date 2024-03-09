import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:match_it/classes/card_data.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.cardData});

  final CardData cardData;

  @override
  Widget build(BuildContext context) {
    if (cardData.imageUrl != null) {
      return _ImageCard(cardData: cardData);
    }

    return _TextCard(cardData: cardData);
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({super.key, required this.cardData});

  final CardData cardData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            image: DecorationImage(
              image: CachedNetworkImageProvider(cardData.imageUrl!),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.7, 1],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    cardData.name,
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                if (cardData.description != null)
                  Text(
                    cardData.description!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextCard extends StatelessWidget {
  const _TextCard({super.key, required this.cardData});

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
