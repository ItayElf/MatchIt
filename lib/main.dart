import 'package:flutter/material.dart';
import 'package:match_it/collections/collections_manager.dart';
import 'package:match_it/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CollectionManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatchIt!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
