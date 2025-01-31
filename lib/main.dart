import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/favorites_provider.dart';
import '/screens/WelcomeScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: ChocoCookiesApp(),
    ),
  );
}

class ChocoCookiesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Choco Cookies',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: WelcomeScreen(),
    );
  }
}
