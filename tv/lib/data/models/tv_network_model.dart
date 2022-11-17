import 'package:equatable/equatable.dart';

import '../../domain/entities/network.dart';

class NetworkModel extends Equatable {
  NetworkModel({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  String? name;
  int id;
  String? logoPath;
  String? originCountry;

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
    name: json["name"],
    id: json["id"],
    logoPath: json["logo_path"] == null ? null : json["logo_path"],
    originCountry: json["origin_country"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "logo_path": logoPath == null ? null : logoPath,
    "origin_country": originCountry,
  };

  Network toEntity() {
    return Network(
        name: name, id: id, logoPath: logoPath, originCountry: originCountry);
  }

  @override
  List<Object?> get props => [
    name,
    id,
    logoPath,
    originCountry,
  ];
}
