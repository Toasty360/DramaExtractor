// ignore_for_file: prefer_const_constructors
import '../lib/extractor.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String baseURL = "https://dramacool.pa/";
  String wikiURL = "https://asianwiki.co";
  late Scraper extractor = Scraper(baseURL, wikiURL);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      body: Center(
        child: ListView(children: [
          TextButton(
              onPressed: () {
                extractor
                    .fetchInfo("kimi-ga-kokoro-wo-kuretakara")
                    .then((value) => Toast.show(value.id ?? " no data"));
              },
              child: Text("Info")),
          TextButton(
              onPressed: () {
                extractor
                    .trending()
                    .then((value) => Toast.show(value.length.toString()));
              },
              child: Text("trending")),
          TextButton(
              onPressed: () {
                extractor
                    .fetchPopular()
                    .then((value) => Toast.show(value.length.toString()));
              },
              child: Text("popular")),
          TextButton(
              onPressed: () {
                extractor
                    .recent()
                    .then((value) => Toast.show(value.length.toString()));
              },
              child: Text("recent")),
          TextButton(
              onPressed: () {
                extractor
                    .fetchActor("/star/cha-soo-yeon")
                    .then((value) => Toast.show(value.name ?? "not found"));
              },
              child: Text("actor info")),
          TextButton(
              onPressed: () {
                extractor
                    .search("hero", "1")
                    .then((value) => Toast.show(value.length.toString()));
              },
              child: Text("search")),
          TextButton(
              onPressed: () {
                extractor
                    .fetchStreamingLinks(
                        "/captivating-the-king-2024-episode-5.html")
                    .then((value) => Toast.show(value["src"]));
              },
              child: Text("streming links")),
        ]),
      ),
    );
  }
}
