import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:wallpaper_by_prashant/fullscreen.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    // here in this URl bydefault the page number is 1
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          "Authorization":
              "4kRcSU3wLqn0n7u3EtnzRKSGfcYyy8BsBjLcOIr1eNbX5iZZlpXZT8cr"
        }).then((value) {
      Map result = jsonDecode(value.body);
      print(result);
      setState(() {
        images = result["photos"];
      });
      print("Photos => ${images}");
    });
  }

  loadMore() async {
    setState(() {
      pageNo = pageNo + 1;
    });
    // adding the page number to load more button by changing the URl
    String url = "https://api.pexels.com/v1/curated?per_page=80&page=" +
        pageNo.toString();

    await http.get(Uri.parse(url), headers: {
      "Authorization":
          "4kRcSU3wLqn0n7u3EtnzRKSGfcYyy8BsBjLcOIr1eNbX5iZZlpXZT8cr"
    }).then((value) {
      Map result = jsonDecode(value.body);

      // adding th new page photos o the previous list of images to show in continuing manner
      setState(() {
        images.addAll(result["photos"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              child: GridView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 100,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Fullscreen(
                                imageUrl: images[index]["src"]["large2x"],
                              ),
                            ));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          images[index]["src"]["tiny"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              loadMore();
            },
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
              child: const Center(
                child: Text(
                  "Load More...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
