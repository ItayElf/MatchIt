import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:match_it/classes/card_data.dart';
import 'package:match_it/classes/message.dart';
import 'package:network_info_plus/network_info_plus.dart';

class Server {
  Server({required this.onError, required this.onLikedCard});

  final void Function(String errorMessage) onError;
  final void Function(CardData cardData) onLikedCard;

  final List<Socket> sockets = [];
  ServerSocket? server;
  bool isRunning = false;

  void start() async {
    runZonedGuarded(
      () async {
        final info = NetworkInfo();
        final ipAddress = await info.getWifiIP();
        if (ipAddress == null) {
          return onError("No ip address was found!");
        }
        server = await ServerSocket.bind(ipAddress, 1664);
        debugPrint("SERVER STARTS ON $ipAddress:1664");
        isRunning = true;
        server!.listen(onRequest);
      },
      (obj, stack) => onError(obj.toString()),
    );
  }

  void stop() async {
    await server?.close();
    server = null;
    isRunning = false;
    sockets.clear();
  }

  void broadcastChoice(CardData cardData) async {
    final message = Message(type: "choice", content: cardData.toMap());
    _broadcast(message);
  }

  void _broadcast(Message message) async {
    final encoded = message.toJson();
    debugPrint("SERVER SENDING: $encoded");
    for (final socket in sockets) {
      socket.write(Uint8List.fromList(encoded.codeUnits));
    }
    await Future.wait(sockets.map((e) => e.flush()));
  }

  void onRequest(Socket socket) {
    debugPrint("GOT CONNECTION FROM ${socket.remoteAddress.address}");
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }
    socket.listen((data) {
      _onData(utf8.decode(data));
    });
  }

  void _onData(String data) {
    debugPrint("SERVER GOT: $data");
    final message = Message.fromJson(data);
    if (message.type == "liked") {
      onLikedCard(CardData.fromJson(data));
    }
  }
}
