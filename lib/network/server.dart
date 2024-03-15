import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/classes/card_data.dart';
import 'package:match_it/classes/message.dart';
import 'package:network_info_plus/network_info_plus.dart';

class Server {
  Server();

  void Function(String errorMessage)? _onError;
  void Function(CardData cardData)? _onLikedCard;
  void Function()? _onJoin;

  final List<Socket> sockets = [];
  ServerSocket? server;
  bool isRunning = false;
  StreamSubscription<Socket>? listenSubscription;

  Future broadcastChoice(CardData cardData) async {
    final message = Message(type: "choice", content: cardData.toMap());
    return _broadcast(message);
  }

  Future broadcastCollection(CardCollection collection) async {
    final message = Message(type: "collection", content: collection.toMap());
    return _broadcast(message);
  }

  void _onRequest(Socket socket) {
    debugPrint("GOT CONNECTION FROM ${socket.remoteAddress.address}");
    if (!sockets.contains(socket)) {
      sockets.add(socket);
      if (_onJoin != null) {
        _onJoin!();
      }
    }
    socket.listen((data) {
      _onData(utf8.decode(data));
    });
  }

  void _onData(String data) {
    debugPrint("SERVER GOT: $data");
    final message = Message.fromJson(data);
    if (message.type == "liked" && _onLikedCard != null) {
      _onLikedCard!(CardData.fromJson(data));
    }
  }

  // Setters

  void onError(void Function(String errorMessage) function) {
    _onError = function;
  }

  void onLikedCard(void Function(CardData cardData) function) {
    _onLikedCard = function;
  }

  void onJoin(void Function() function) {
    _onJoin = function;
  }

  // Low level networking

  void start() async {
    runZonedGuarded(
      () async {
        final info = NetworkInfo();
        final ipAddress = await info.getWifiIP();
        if (ipAddress == null && _onError != null) {
          return _onError!("No ip address was found!");
        }
        server = await ServerSocket.bind(ipAddress, 1664);
        debugPrint("SERVER STARTS ON $ipAddress:1664");
        isRunning = true;
        listenSubscription = server!.listen(_onRequest);
      },
      (obj, stack) => _onError != null ? _onError!(obj.toString()) : null,
    );
  }

  Future<void> lock() async {
    await listenSubscription?.cancel();
  }

  void stop() async {
    await lock();
    await server?.close();
    server = null;
    isRunning = false;
    listenSubscription = null;
    sockets.clear();
  }

  Future _broadcast(Message message) async {
    final encoded = message.toJson();
    debugPrint("SERVER SENDING: $encoded");
    for (final socket in sockets) {
      socket.write(encoded);
    }
    return Future.wait(sockets.map((e) => e.flush()));
  }
}
