import 'dart:convert';

import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/collections/food_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionManager {
  static SharedPreferences? preferences;

  static const List<CardCollection> collections = [
    foodCollection,
  ];

  static Future initialize() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences!.getString("collections") == null) {
      await preferences!.setString(
        "collections",
        jsonEncode(collections.map((e) => e.toMap()).toList()),
      );
    }
  }

  static List<CardCollection> getAllCollections() {
    final collectionsString = preferences!.getString("collections")!;
    final list = jsonDecode(collectionsString) as List;
    return list.map((e) => CardCollection.fromMap(e)).toList();
  }
}
