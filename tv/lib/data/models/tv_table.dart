import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv_model.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';

class TvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvTable.fromEntity(TvDetail tvDetail) => TvTable(
      id: tvDetail.id,
      name: tvDetail.name,
      posterPath: tvDetail.posterPath,
      overview: tvDetail.overview);

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
      id: map['id'],
      name: map['name'],
      posterPath: map['posterPath'],
      overview: map['overview']);

  factory TvTable.fromDTO(TvModel tv) => TvTable(
      id: tv.id,
      name: tv.name,
      posterPath: tv.posterPath,
      overview: tv.overview);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "posterPath": posterPath, "overview": overview};

  Tv toEntity() => Tv.watchList(
      id: id, overview: overview, name: name, posterPath: posterPath);

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
