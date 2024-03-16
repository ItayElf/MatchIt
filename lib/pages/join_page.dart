import 'package:flutter/material.dart';
import 'package:match_it/network/client.dart';
import 'package:match_it/network/utils.dart';
import 'package:match_it/pages/client_swipe_page.dart';
import 'package:match_it/widgets/async_button.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  late Client client;
  final ipHashController = TextEditingController();
  bool isConnected = false;
  int? connected;

  @override
  void initState() {
    super.initState();

    client = Client();
    client.onConnected(
      () => setState(() {
        isConnected = true;
      }),
    );
  }

  @override
  void dispose() {
    ipHashController.dispose();
    super.dispose();
  }

  Future onConnect(BuildContext context) async {
    if (ipHashController.text.isEmpty) return;
    String ip = "0.0.0.0";
    try {
      ip = hashIdToIp(ipHashController.text);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid code!")),
      );
      return;
    }
    return client.connect(ip);
  }

  @override
  Widget build(BuildContext context) {
    client.onError(
      (error) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      ),
    );

    client.onCollection(
      (collection) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              ClientSwipePage(collection: collection, client: client),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Join a Decision"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: isConnected
              ? _ConnectedScreen()
              : _NotConnectedScreen(
                  ipHashController: ipHashController, onConnect: onConnect),
        ),
      ),
    );
  }
}

class _NotConnectedScreen extends StatelessWidget {
  const _NotConnectedScreen(
      {required this.ipHashController, required this.onConnect});

  final TextEditingController ipHashController;
  final Future Function(BuildContext context) onConnect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text(
                "Enter Code:",
                style: TextStyle(fontSize: 36),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 16, left: 32, right: 32),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Code from host',
                    hintStyle: const TextStyle(fontSize: 28),
                  ),
                  style: const TextStyle(fontSize: 48),
                  controller: ipHashController,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                "Connect to be a part of the decision!",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: AsyncButton(
            onClick: () => onConnect(context),
            child: const Text(
              "Connect!",
              style: TextStyle(fontSize: 48),
            ),
          ),
        )
      ],
    );
  }
}

class _ConnectedScreen extends StatelessWidget {
  const _ConnectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Connected!",
          style: TextStyle(fontSize: 48),
        ),
        Text(
          "Waiting for the host to start...",
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
