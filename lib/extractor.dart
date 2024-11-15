// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'model.dart';

class Scraper {
  String baseURL = "https://asianc.co/";
  String wikiURL = "https://asianwiki.co";
  Dio dio = Dio();

  Scraper(this.baseURL, this.wikiURL) {
    dio = Dio();
  }

  Future<Drama> fetchInfo(String url) async {
    if (!url.contains("https")) {
      url = "$baseURL/drama-detail/$url";
    }

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final document = parse(response.data);
        Drama info = Drama()
          ..id = url
          ..title = document.querySelector(".info h1")?.text ?? ""
          ..altTitles = document
              .querySelectorAll(".other_name a")
              .map((element) => element.text)
              .toList()
          ..image = document
                  .querySelector(".details > .img > img")
                  ?.attributes['src'] ??
              ""
          ..trailer =
              document.querySelector(".trailer > iframe")?.attributes['src'] ??
                  ""
          ..year = document
              .querySelectorAll(".info p")
              .firstWhere((e) => e.text.contains("Released:"))
              .text
              .replaceFirst("Released:", "")
              .trim()
          ..country = document
              .querySelectorAll(".info p")
              .firstWhere((e) => e.text.contains("Country:"))
              .text
              .replaceFirst("Country:", "")
              .trim()
          ..status = document
              .querySelectorAll(".info p")
              .firstWhere((e) => e.text.contains("Status:"))
              .text
              .replaceFirst("Status:", "")
              .trim()
          ..actors = document
              .querySelectorAll(".slider-star > div")
              .map((element) => Actor(id: '')
                ..name = element.querySelector(".title")?.text.trim() ?? ""
                ..image = element.querySelector("img")?.attributes['src'] ?? ""
                ..id = element.querySelector("a")?.attributes['href'] ?? "")
              .toList()
          ..totalEpisodes =
              document.querySelectorAll(".all-episode > li").length
          ..episodes = document
              .querySelectorAll(".all-episode > li")
              .map((element) => Episode()
                ..id = element.querySelector("a")?.attributes['href'] ?? ""
                ..name = element.querySelector(".title")?.text.trim() ?? ""
                ..type = element.querySelector(".type")?.text.trim() ?? ""
                ..date = element.querySelector(".time")?.text.trim() ?? "")
              .toList();
        if (info.totalEpisodes == 0) {
          info.genre = document
              .querySelectorAll(".info p")
              .last
              .previousElementSibling!
              .querySelectorAll("a")
              .map((e) => e.text)
              .toList();
          info.airs = document
              .querySelectorAll(".info p")
              .last
              .text
              .split(":")
              .last
              .trim();
        } else {
          info.genre = document
              .querySelectorAll(".info p")
              .last
              .querySelectorAll("a")
              .map((e) => e.text)
              .toList();
        }
        document.querySelectorAll(".info p").forEach((element) {
          if (element.querySelector("span") == null && element.text != "") {
            if (info.description.runtimeType != Null) {
              info.description = info.description! + "\n" + element.text;
            } else {
              info.description = element.text;
            }
          }
        });

        return info;
      } else {}
    } catch (e) {}
    return Drama();
  }

  Future<List<Drama>> trending() async {
    try {
      final response = await dio.get(
        baseURL,
        options: Options(
          followRedirects: true,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "User-Agent":
                "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36",
          },
        ),
      );

      if (response.statusCode == 200) {
        final document = parse(response.data);

        List<Drama> data = [];

        document.querySelectorAll("#layerslider .ls-slide").forEach((element) {
          Drama item = Drama()
            ..id = element.querySelector("a")?.attributes['href'] ?? ""
            ..title = element.querySelector("img")?.attributes['title'] ?? ""
            ..description = ""
            ..image = element.querySelector("img")?.attributes['src'] ?? "";
          data.add(item);
        });

        return data;
      }
    } catch (e) {}

    return [];
  }

  Future<List<Drama>> search(String q, String page) async {
    var url = '$wikiURL/search?keyword=$q&page=$page';

    try {
      final response = await dio.get(
        url,
        options: Options(
          followRedirects: true,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "User-Agent":
                "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36",
          },
        ),
      );

      if (response.statusCode == 200) {
        final document = parse(response.data);

        List<Drama> data = [];

        document
            .querySelectorAll(".content-l-item > .col-2 > li")
            .forEach((element) {
          data.add(Drama()
            ..id = element
                    .querySelector("a")
                    ?.attributes['href']
                    ?.replaceFirst("asian-wiki", "drama-detail")
                    .replaceAll(".html", "")
                    .trim() ??
                ""
            ..image = element.querySelector("img")?.attributes['src'] ?? ""
            ..title = element.querySelector("h3")?.text ?? ""
            ..status = element.querySelectorAll(".meta > span").last.text
            ..year = element.querySelectorAll(".meta > span").first.text
            ..country = element
                    .querySelectorAll(".meta > span")
                    .last
                    .previousElementSibling
                    ?.text ??
                "");
        });

        return data;
      }
    } catch (e) {}

    return [];
  }

  Future<List<Drama>> recent() async {
    try {
      final response = await dio.get(
        baseURL,
        options: Options(
          followRedirects: true,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "User-Agent":
                "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36",
          },
        ),
      );

      if (response.statusCode == 200) {
        final document = parse(response.data);

        List<Drama> data = [];

        document.querySelectorAll(".list-episode-item > li").forEach((element) {
          data.add(Drama()
            ..id = element.querySelector("a")?.attributes['href'] ?? ""
            ..image =
                element.querySelector("img")?.attributes['data-original'] ?? ""
            ..title = element.querySelector("h3")?.text ?? ""
            ..type = element.querySelector(".type")?.text ?? ""
            ..time = element.querySelector(".time")?.text ?? ""
            ..epsNumber = double.parse(
                element.querySelector(".ep")?.text.split(" ")[1] ?? "0"));
        });

        return data;
      }
    } catch (e) {}

    return [];
  }

  Future<List<Drama>> fetchPopular() async {
    try {
      final response = await dio.get("$wikiURL/most-watched.html");

      if (response.statusCode == 200) {
        final document = parse(response.data);

        List<Drama> data = [];

        document
            .querySelectorAll(".content-l-item > .col-2 > li")
            .forEach((element) {
          data.add(Drama()
            ..id = element
                    .querySelector("a")
                    ?.attributes['href']
                    ?.replaceFirst("asian-wiki", "drama-detail")
                    .replaceAll(".html", "")
                    .trim() ??
                ""
            ..image = element.querySelector("img")?.attributes['src'] ?? ""
            ..title = element.querySelector("h3")?.text ?? ""
            ..status = element.querySelectorAll(".meta > span").last.text
            ..year = element.querySelectorAll(".meta > span").first.text
            ..country = element
                    .querySelectorAll(".meta > span")
                    .last
                    .previousElementSibling
                    ?.text ??
                "");
        });

        return data;
      }
    } catch (e) {}

    return [];
  }

  Future<Actor> fetchActor(String id) async {
    var actor = Actor(id: id);
    id = id.endsWith(".html") ? id : "$id.html";
    final response = await dio.get("https://asianwiki.co/$id");

    if (response.statusCode == 200) {
      final document = parse(response.data);

      actor.name = document
          .querySelector(".content-l-item .info-drama > h1")
          ?.text
          .replaceFirst(RegExp(r'\([0-9].*\)'), "");
      actor.otherNames = document
          .querySelectorAll(".content-l-item .info-drama > .other_name > a")
          .map((element) => element.attributes['title'])
          .toList()
          .cast<String>();
      actor.age = document
          .querySelector(".other_name")
          ?.nextElementSibling
          ?.text
          .replaceFirst("Age:", "")
          .trim();
      actor.dob = document
          .querySelectorAll(".info-drama > div")
          .firstWhere((e) => e.text.contains("Born:"))
          .text
          .replaceFirst("Born:", "")
          .trim();
      actor.height = document
          .querySelectorAll(".info-drama > div")
          .firstWhere((e) => e.text.contains("Height:"))
          .text
          .replaceFirst("Height:", "")
          .trim();
      actor.nationality = document
          .querySelectorAll(".info-drama > div")
          .firstWhere((e) => e.text.contains("Nationality:"))
          .text
          .replaceFirst("Nationality:", "")
          .trim();
      actor.image = document
          .querySelector(".content-l-item > .thumb-drama")
          ?.attributes['src'];
      actor.about = document.querySelectorAll(".info-drama > div").last.text;
      actor.movies = [];

      document
          .querySelectorAll(".content-l-item > .col-2 > li")
          .forEach((element) {
        actor.movies!.add(Drama(
          id: element
                  .querySelector("a")
                  ?.attributes['href']
                  ?.replaceFirst("asian-wiki", "drama-detail")
                  .replaceAll(".html", "")
                  .trim() ??
              "",
          image: element.querySelector("a > img")?.attributes['src'],
          title: element.querySelector("h3")?.text ?? "",
          status: element.querySelectorAll(".meta > span").last.text,
          year: element.querySelectorAll(".meta > span").first.text,
          country: element
                  .querySelectorAll(".meta > span")
                  .last
                  .previousElementSibling
                  ?.text ??
              "",
        ));
      });
    }

    return actor;
  }

  Future<Map> fetchStreamingLinks(String id, {StreamProvider? provider}) async {
    try {
      print(baseURL + id);
      final response = await dio.get(
        baseURL + id,
        options: Options(
          headers: {
            'Referer': baseURL,
            'Access-Control-Allow-Origin': '*',
            'User-Agent':
                'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36',
          },
        ),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        switch (provider) {
          case StreamProvider.Streamwish:
            return _StreamWish(response.data!);
          case StreamProvider.StreamTape:
            return _StreamTape(response.data!);
          case StreamProvider.DoodStream:
            return _DoodStream(response.data!);
          default:
            return Asianload().extract(response.data!);
        }
      }
      throw new Exception("Something went wrong");
    } catch (e) {
      return {"src": "not found"};
    }
  }

  Future<Map> _StreamWish(String s) async {
    try {
      var match =
          RegExp(r'<li class="streamwish" rel="\d+" data-video="([^"]+)">')
              .firstMatch(s);
      if (match.runtimeType != Null) {
        var u = match![1];

        var v = await dio.get(u!,
            options: Options(
              headers: {'Referer': baseURL},
            ));
        var t = await v.data;
        return {
          "src": RegExp(r'file:\s*"([^"]+)"').firstMatch(t)!.group(1)!,
          "type": 'm3u8',
          "referer": '',
        };
      }
    } catch (e) {}
    return {"src": "not found"};
  }

  Future<Map> _StreamTape(String s) async {
    try {
      var tape = await (await dio.get(
              RegExp(r'<li class="streamtape" rel="\d+" data-video="([^"]+)">')
                  .firstMatch(s)![1]!,
              options: Options(
                headers: {'Referer': baseURL},
              )))
          .data;
      return {
        "src":
            "https://streamtape.com/get_video?id=${RegExp(r"defg([^']+)").allMatches(tape).last[0]!.split("?id=").last}&stream=1",
        "type": "video/mp4",
        "referer": 'https://streamtape.com',
      };
    } catch (e) {}
    return {"src": "not found"};
  }

  Future<Map> _DoodStream(String s) async {
    var doodybaseurl = "https://d0000d.com";
    var url = RegExp(r'<li class="doodstream" rel="\d+" data-video="([^"]+)">')
        .firstMatch(s)![1];
    try {
      var dood = await (await dio.get(url!,
              options: Options(
                headers: {'Referer': baseURL},
              )))
          .data;
      var resp = await (await dio.get(
              doodybaseurl +
                  "/pass_md5/" +
                  RegExp(r"\$.get\('\/pass_md5\/([^']+)'")
                      .firstMatch(dood)![1]!,
              options: Options(
                headers: {'Referer': doodybaseurl},
              )))
          .data;

      return {
        "src": dood.contains("src: data + makePlay()")
            ? resp +
                "urcodesucks?token=${RegExp(r'\?token=([^&]+)').firstMatch(dood)![1]}&expiry=${DateTime.now().millisecondsSinceEpoch}"
            : resp.data,
        "type": "video/mp4",
        "referer": doodybaseurl
      };
    } catch (e) {}
    return {"src": "not found"};
  }
}

class Asianload {
  final String baseURL = "https://asianc.co/";
  final key = encrypt.Key.fromBase64(
      base64.encode(utf8.encode("93422192433952489752342908585752")));
  final iv =
      encrypt.IV.fromBase64(base64.encode(utf8.encode("9262859232435825")));
  String _decryptAES(String encryptedText) {
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }

  String _encryptAES(String text) {
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  Future<Map> extract(String resp) async {
    var url =
        "https:" + RegExp(r'data-video="(.*?)"').firstMatch(resp)!.group(1)!;
    var resp1 = await Dio().get(url);
    var hash = RegExp(r'data-value="(.*?)"').firstMatch(resp1.data)!.group(1);
    var data2 = _decryptAES(hash!);
    var data3 = data2.substring(0, data2.indexOf("&"));
    var params =
        "id=${Uri.encodeComponent(_encryptAES(data3))}${data2.substring(data2.indexOf("&"))}&${Uri.encodeComponent(data3)}";
    var encodedShit =
        await Dio().get("https://pladrac.net/encrypt-ajax.php?" + params);
    return jsonDecode(_decryptAES(jsonDecode(encodedShit.data)["data"]));
  }
}
