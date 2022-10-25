import 'package:flutter/material.dart';
import 'package:mod3_kel15/screens/DetailManga.dart';
import 'package:mod3_kel15/screens/ListManga.dart';
import 'package:mod3_kel15/screens/Profile.dart';
import 'package:mod3_kel15/screens/home.dart';
import 'package:mod3_kel15/screens/splashscreen.dart';

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
        '/list': (context) => const ListMangaPage(),
        '/detail': (context) => const DetailMangaPage(item: 0, title: ''),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
