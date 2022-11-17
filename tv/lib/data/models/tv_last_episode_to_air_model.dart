import 'package:equatable/equatable.dart';

import '../../domain/entities/last_episode_to_air.dart';

class LastEpisodeToAirModel extends Equatable {
  LastEpisodeToAirModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  String? airDate;
  int? episodeNumber;
  int id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  String? stillPath;
  double? voteAverage;
  int? voteCount;

  factory LastEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAirModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
    "air_date": airDate,
    "episode_number": episodeNumber,
    "id": id,
    "name": name,
    "overview": overview,
    "production_code": productionCode,
    "season_number": seasonNumber,
    "still_path": stillPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  LastEpisodeToAir toEntity() => LastEpisodeToAir(
      airDate: airDate,
      episodeNumber: episodeNumber,
      id: id,
      name: name,
      overview: overview,
      productionCode: productionCode,
      seasonNumber: seasonNumber,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount);

  @override
  List<Object?> get props => [
    airDate,
    episodeNumber,
    id,
    name,
    overview,
    productionCode,
    seasonNumber,
    stillPath,
    voteAverage,
    voteCount,
  ];
}
