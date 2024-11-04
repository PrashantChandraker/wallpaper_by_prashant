import 'package:flutter/material.dart';
import 'package:wallpaper_by_prashant/wallpaper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home:  Wallpaper(),
    );
  }
}
