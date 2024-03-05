import 'package:extractor/model.dart';
import 'package:test/test.dart';
import "../lib/extractor.dart";

void main() {
  Scraper extractor = Scraper("https://dramacool.pa/", "https://asianwiki.co");

  test('Should return drama name', () async {
    var data = await extractor.fetchInfo("queen-of-tears");
    expect(data.title, isNot(null));
  });
  test('Should return list of trending drama', () async {
    var data = await extractor.trending();
    expect(data.length, isNot(0));
  });
  test('Should return list of trending drama', () async {
    var data = await extractor.recent();
    expect(data.length, isNot(0));
  });
  test('Should return list of popular drama', () async {
    var data = await extractor.fetchPopular();
    expect(data.length, isNot(0));
  });
  test('Should return actor data', () async {
    var data = await extractor.fetchActor("/star/cha-soo-yeon");
    expect(data.name, isNot(null));
    expect(data.movies, isNot(null));
  });
  test('Should return search data for hero', () async {
    var data = await extractor.search("hero", "1");
    expect(data.length, isNot(0));
  });
  test('Should return StreamTape links', () async {
    var data = await extractor.fetchStreamingLinks(
        "/captivating-the-king-2024-episode-10.html",
        StreamProvider.StreamTape);
    expect(data["src"], isNot("not found"));
  });
  test('Should return Streamwish links', () async {
    var data = await extractor.fetchStreamingLinks(
        "/captivating-the-king-2024-episode-10.html",
        StreamProvider.Streamwish);
    expect(data["src"], isNot("not found"));
  });
  test('Should return DoodStream links', () async {
    var data = await extractor.fetchStreamingLinks(
        "/captivating-the-king-2024-episode-10.html",
        StreamProvider.DoodStream);
    expect(data["src"], isNot("not found"));
  });
}
