import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Drama {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? id;

  @HiveField(2)
  String? year;

  @HiveField(3)
  List<Episode>? episodes;

  @HiveField(4)
  String? description;

  @HiveField(5)
  List<String>? altTitles;

  @HiveField(6)
  String? country;

  @HiveField(7)
  List<String>? genre;

  @HiveField(8)
  String? image;

  @HiveField(9)
  String? status;

  @HiveField(10)
  String? trailer;

  @HiveField(11)
  int? totalEpisodes;

  @HiveField(12)
  String? time;

  @HiveField(13)
  String? type;

  @HiveField(14)
  double? epsNumber;

  @HiveField(15)
  List<Actor>? actors;

  @HiveField(16)
  String? airs;

  Drama({
    this.title,
    this.id,
    this.year,
    this.episodes,
    this.description,
    this.altTitles,
    this.country,
    this.genre,
    this.image,
    this.status,
    this.trailer,
    this.totalEpisodes,
    this.time,
    this.type,
    this.epsNumber,
    this.actors,
    this.airs,
  });
}

@HiveType(typeId: 1)
class Episode {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? type;

  @HiveField(2)
  String? date;

  @HiveField(3)
  String? id;

  @HiveField(4)
  String? image;

  Episode({
    this.name,
    this.type,
    this.date,
    this.id,
    this.image,
  });
}

@HiveType(typeId: 2)
class Actor {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? image;

  @HiveField(2)
  String id;

  @HiveField(3)
  List<String>? otherNames;

  @HiveField(4)
  String? age;

  @HiveField(5)
  String? dob;

  @HiveField(6)
  String? nationality;

  @HiveField(7)
  String? height;

  @HiveField(8)
  String? about;

  @HiveField(9)
  List<Drama>? movies;

  Actor({
    required this.id,
    this.name,
    this.image,
    this.otherNames,
    this.age,
    this.dob,
    this.nationality,
    this.height,
    this.about,
    this.movies,
  });
}

enum StreamProvider { Streamwish, StreamTape, DoodStream }
