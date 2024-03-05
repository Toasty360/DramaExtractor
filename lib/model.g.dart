// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DramaAdapter extends TypeAdapter<Drama> {
  @override
  final int typeId = 0;

  @override
  Drama read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Drama(
      title: fields[0] as String?,
      id: fields[1] as String?,
      year: fields[2] as String?,
      episodes: (fields[3] as List?)?.cast<Episode>(),
      description: fields[4] as String?,
      altTitles: (fields[5] as List?)?.cast<String>(),
      country: fields[6] as String?,
      genre: (fields[7] as List?)?.cast<String>(),
      image: fields[8] as String?,
      status: fields[9] as String?,
      trailer: fields[10] as String?,
      totalEpisodes: fields[11] as int?,
      time: fields[12] as String?,
      type: fields[13] as String?,
      epsNumber: fields[14] as double?,
      actors: (fields[15] as List?)?.cast<Actor>(),
      airs: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Drama obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.episodes)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.altTitles)
      ..writeByte(6)
      ..write(obj.country)
      ..writeByte(7)
      ..write(obj.genre)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.trailer)
      ..writeByte(11)
      ..write(obj.totalEpisodes)
      ..writeByte(12)
      ..write(obj.time)
      ..writeByte(13)
      ..write(obj.type)
      ..writeByte(14)
      ..write(obj.epsNumber)
      ..writeByte(15)
      ..write(obj.actors)
      ..writeByte(16)
      ..write(obj.airs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DramaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EpisodeAdapter extends TypeAdapter<Episode> {
  @override
  final int typeId = 1;

  @override
  Episode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Episode(
      name: fields[0] as String?,
      type: fields[1] as String?,
      date: fields[2] as String?,
      id: fields[3] as String?,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Episode obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ActorAdapter extends TypeAdapter<Actor> {
  @override
  final int typeId = 2;

  @override
  Actor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Actor(
      id: fields[2] as String,
      name: fields[0] as String?,
      image: fields[1] as String?,
      otherNames: (fields[3] as List?)?.cast<String>(),
      age: fields[4] as String?,
      dob: fields[5] as String?,
      nationality: fields[6] as String?,
      height: fields[7] as String?,
      about: fields[8] as String?,
      movies: (fields[9] as List?)?.cast<Drama>(),
    );
  }

  @override
  void write(BinaryWriter writer, Actor obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.otherNames)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.nationality)
      ..writeByte(7)
      ..write(obj.height)
      ..writeByte(8)
      ..write(obj.about)
      ..writeByte(9)
      ..write(obj.movies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
