import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {

@override
void initState(){
  super.initState();
  fetchApi();
}

  fetchApi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          "Authorization":
              "4kRcSU3wLqn0n7u3EtnzRKSGfcYyy8BsBjLcOIr1eNbX5iZZlpXZT8cr"
        }).then((value) {
      
      Map result = jsonDecode(value.body);
      print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: 80,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                    );
                  }),
            ),
          ),
           SizedBox(height: 10,),
          BeautifulButton(
            label: 'Beautiful Button',
            onPressed: () {
              // Add button action here
              print('Button Pressed');
            },
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}

class BeautifulButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const BeautifulButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

