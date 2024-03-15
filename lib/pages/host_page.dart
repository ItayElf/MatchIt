import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:match_it/classes/card_collection.dart';
import 'package:match_it/network/server.dart';
import 'package:match_it/network/utils.dart';
import 'package:match_it/widgets/async_button.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key, required this.collection});

  final CardCollection collection;

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  late Server server;
  String wifiName = "same";
  String ipHash = "";
  int connected = 1;

  @override
  void initState() {
    super.initState();
    server = Server();
    server.start();

    server.onJoin(
      () => setState(() {
        connected += 1;
      }),
    );

    _setup();
  }

  Future _setup() async {
    if (Platform.isAndroid) {
      final status = await Permission.location.status;
      if (status.isDenied || status.isRestricted) {
        await Permission.location.request();
      }
    }

    final info = NetworkInfo();
    String tempWifiName = await info.getWifiName() ?? "same";
    String? ip = await info.getWifiIP();
    String tempIpHash;
    if (ip != null) {
      tempIpHash = ipToHashId(ip);
    } else {
      tempIpHash = "ERROR";
    }

    setState(() {
      wifiName = tempWifiName;
      ipHash = tempIpHash;
    });
  }

  Future onStart() async {
    await server.lock();
  }

  @override
  Widget build(BuildContext context) {
    server.onError(
      (error) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error))),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Host | ${widget.collection.name}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Code to join:",
                      style: TextStyle(fontSize: 36),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      child: SelectableText(
                        ipHash,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      "Connected: $connected",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: AsyncButton(
                    onClick: onStart,
                    child: const Text(
                      "Start!",
                      style: TextStyle(fontSize: 48),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
