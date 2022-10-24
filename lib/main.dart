import 'package:flutter/material.dart';
import 'package:mod3_kel15/screens/home.dart';
import 'package:mod3_kel15/screens/splashscreen.dart';
import 'screens/detail.dart';

void main() async {
  runApp(const AnimeApp());
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime app',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreenPage(),
        '/home': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(item: 0, title: ''),
      },
    );
  }
}
