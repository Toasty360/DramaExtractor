import 'package:dio/dio.dart';

import 'package:test/test.dart';
import "../lib/extractor.dart";

void main() {
  Scraper extractor = Scraper("https://asianc.co/", "https://asianwiki.co");

  // test('Should return drama name', () async {
  //   var data = await extractor.fetchInfo("queen-of-tears");
  //   expect(data.title, isNot(null));
  // });
  // test('Should return list of trending drama', () async {
  //   var data = await extractor.trending();
  //   expect(data.length, isNot(0));
  // });
  // test('Should return list of trending drama', () async {
  //   var data = await extractor.recent();
  //   expect(data.length, isNot(0));
  // });
  // test('Should return list of popular drama', () async {
  //   var data = await extractor.fetchPopular();
  //   expect(data.length, isNot(0));
  // });
  // test('Should return actor data', () async {
  //   var data = await extractor.fetchActor("/star/cha-soo-yeon");
  //   expect(data.name, isNot(null));
  //   expect(data.movies, isNot(null));
  // });
  // test('Should return search data for hero', () async {
  //   var data = await extractor.search("hero", "1");
  //   expect(data.length, isNot(0));
  // });
  test('Should return StreamTape links', () async {
    var data = await extractor
        .fetchStreamingLinks("/queen-of-tears-2024-episode-6.html");
    print(data["src"]);
    expect(data["src"], isNot("not found"));
  });
  // test('Should return Streamwish links', () async {
  //   var data = await extractor.fetchStreamingLinks(
  //       "/queen-of-tears-2024-episode-6.html", StreamProvider.Streamwish);
  //   getQualities(data["src"]);
  //   expect(data["src"], isNot("not found"));
  // });
  // test('Should return DoodStream links', () async {
  //   var data = await extractor.fetchStreamingLinks(
  //       "/queen-of-tears-2024-episode-6.html", StreamProvider.DoodStream);
  //   print(data["src"]);

  //   expect(data["src"], isNot("not found"));
  // });
}

// getSrc() async {
//   var data = (await Dio().get(
//           "https://valerien-api.vercel.app/drama/asianload?id=/queen-of-tears-2024-episode-6"))
//       .data;
//   getQualities(data["source"][0]["file"]);
// }

getQualities(String src) async {
  try {
    var base = src.substring(0, src.lastIndexOf("/")) + "/";
    print(src);
    src = await (await Dio().get(src)).data;
    List<Map<String, dynamic>> qualities = [];
    List<String> lines = src.split('\n');
    for (String line in lines) {
      if (!line.startsWith('#EXT-X-STREAM-INF') && line.contains("m3u8")) {
        qualities.add({
          'url': base + line,
          'quality': line.split(".").reversed.toList()[1],
        });
      }
    }
    print(qualities);
  } catch (e) {
    print(e);
  }
}

Future<void> getdoody(
    {String url = "https://ds2play.com/e/5toaybrm4exz?autoplay=1"}) async {
  var doodybaseurl = "https://d0000d.com";
  var dio = Dio();
  var dood = await (await dio.get(url,
          options: Options(
            headers: {'Referer': "https://desicinemas.ink/"},
          )))
      .data;
  var resp = await (await dio.get(
          doodybaseurl +
              "/pass_md5/" +
              RegExp(r"\$.get\('\/pass_md5\/([^']+)'").firstMatch(dood)![1]!,
          options: Options(
            headers: {'Referer': doodybaseurl},
          )))
      .data;

  print({
    "src": dood.contains("src: data + makePlay()")
        ? resp +
            "urcodesucks?token=${RegExp(r'\?token=([^&]+)').firstMatch(dood)![1]}&expiry=${DateTime.now().millisecondsSinceEpoch}"
        : resp.data,
    "type": "video/mp4",
    "referer": doodybaseurl
  });
}
