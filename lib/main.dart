import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/pages/home.dart';
import 'package:flutter_app_gallery/pages/favorites_page.dart';
import 'package:flutter_app_gallery/pages/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const Loading(),
          '/home': (context) => const Home(),
          '/favorites' : (context) => const FavoritesPage(favoriteImages: [],),
        },
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Quicksand',
      ),
    );
  }
}


