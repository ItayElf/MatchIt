import 'package:flutter/material.dart';
import 'package:match_it/pages/collection_chooser.dart';
import 'package:match_it/pages/join_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "MatchIt!",
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 48),
            _MenuButton(
              text: "Join",
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const JoinPage()),
              ),
            ),
            const SizedBox(height: 16),
            _MenuButton(
              text: "Host",
              onClick: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CollectionChooser(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const _MenuButton(
              text: "Manage Collections",
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.text,
    this.onClick,
  });

  final String text;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
