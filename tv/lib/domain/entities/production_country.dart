import 'package:equatable/equatable.dart';

class ProductionCountry extends Equatable {
  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  String? iso31661;
  String? name;

  @override
  List<Object?> get props => [
    iso31661,
    name,
  ];
}
