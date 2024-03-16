import 'dart:io';

import 'package:flutter/material.dart';
import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/classes/card_data.dart';
import 'package:match_it/classes/message.dart';
import 'package:match_it/network/utils.dart';

class Client {
  Client();

  void Function(String errorMessage)? _onError;
  void Function(CardCollection collection)? _onCollection;
  void Function(CardData cardData)? _onFinalChoice;
  void Function()? _onConnected;

  Socket? socket;

  Future sendLikedCard(CardData cardData) async {
    final message = Message(type: "liked", content: cardData.toMap());
    socket?.write(message.toJson());
    return socket?.flush();
  }

  void onError(void Function(String errorMessage)? function) {
    _onError = function;
  }

  void onCollection(void Function(CardCollection collection)? function) {
    _onCollection = function;
  }

  void onFinalChoice(void Function(CardData cardData)? function) {
    _onFinalChoice = function;
  }

  void onConnected(void Function()? function) {
    _onConnected = function;
  }

  void _onData(String data) {
    debugPrint("CLIENT GOT: $data");
    final message = Message.fromJson(data);
    if (message.type == "collection" && _onCollection != null) {
      _onCollection!(CardCollection.fromMap(message.content));
    } else if (message.type == "choice" && _onFinalChoice != null) {
      _onFinalChoice!(CardData.fromMap(message.content));
    }
  }

  Future connect(String ip) async {
    try {
      socket = await Socket.connect(
        ip,
        appPortNumber,
        timeout: const Duration(seconds: 5),
      );
      socket!.listen(
        (event) => _onData(String.fromCharCodes(event)),
        onError: (error) =>
            _onError != null ? _onError!(error.toString()) : null,
        onDone: disconnect,
      );
      if (_onConnected != null) _onConnected!();
    } on SocketException catch (error) {
      _onError != null
          ? _onError!(
              "Could not connect to host! Make sure you are in the same WIFI")
          : () => {};
    } on Exception catch (error) {
      _onError != null ? _onError!(error.toString()) : () => {};
    }
  }

  void disconnect() {
    socket?.destroy();
  }
}
