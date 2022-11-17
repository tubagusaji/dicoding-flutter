import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_detail.dart';
import 'tv_createdby_model.dart';
import 'tv_genre_model.dart';
import 'tv_last_episode_to_air_model.dart';
import 'tv_network_model.dart';
import 'tv_production_country_model.dart';
import 'tv_season_model.dart';
import 'tv_spoken_language_model.dart';

class TvDetailModel extends Equatable {
  TvDetailModel({
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  List<CreatedByModel>? createdBy;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<GenreModel>? genres;
  String? homepage;
  int id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAirModel? lastEpisodeToAir;
  String? name;
  List<NetworkModel>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<NetworkModel>? productionCompanies;
  List<ProductionCountryModel>? productionCountries;
  List<SeasonModel>? seasons;
  List<SpokenLanguageModel>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        backdropPath: json["backdrop_path"],
        createdBy: List<CreatedByModel>.from(
            json["created_by"].map((x) => CreatedByModel.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"],
        lastEpisodeToAir:
            LastEpisodeToAirModel.fromJson(json["last_episode_to_air"]),
        name: json["name"],
        networks: List<NetworkModel>.from(
            json["networks"].map((x) => NetworkModel.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<NetworkModel>.from(
            json["production_companies"].map((x) => NetworkModel.fromJson(x))),
        productionCountries: List<ProductionCountryModel>.from(
            json["production_countries"]
                .map((x) => ProductionCountryModel.fromJson(x))),
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        spokenLanguages: List<SpokenLanguageModel>.from(json["spoken_languages"]
            .map((x) => SpokenLanguageModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy!.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime!.map((x) => x)),
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "last_air_date": lastAirDate,
        "last_episode_to_air": lastEpisodeToAir!.toJson(),
        "name": name,
        "networks": List<dynamic>.from(networks!.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            List<dynamic>.from(productionCompanies!.map((x) => x.toJson())),
        "production_countries":
            List<dynamic>.from(productionCountries!.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons!.map((x) => x.toJson())),
        "spoken_languages":
            List<dynamic>.from(spokenLanguages!.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
        backdropPath: backdropPath,
        createdBy: createdBy!.map((e) => e.toEntity()).toList(),
        episodeRunTime: episodeRunTime,
        firstAirDate: firstAirDate,
        genres: genres!.map((e) => e.toEntity()).toList(),
        homepage: homepage,
        id: id,
        inProduction: inProduction,
        languages: languages,
        lastAirDate: lastAirDate,
        lastEpisodeToAir: lastEpisodeToAir!.toEntity(),
        name: name,
        networks: networks!.map((e) => e.toEntity()).toList(),
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        productionCompanies:
            productionCompanies!.map((e) => e.toEntity()).toList(),
        productionCountries:
            productionCountries!.map((e) => e.toEntity()).toList(),
        seasons: seasons!.map((e) => e.toEntity()).toList(),
        spokenLanguages: spokenLanguages!.map((e) => e.toEntity()).toList(),
        status: status,
        tagline: tagline,
        type: type,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}







