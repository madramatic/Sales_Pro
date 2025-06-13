import 'package:equatable/equatable.dart';

class Interaction extends Equatable {
  final int id;
  final String name;
  final String icon;
  final String color;
  final String svg;
  final String createdAt;

  const Interaction({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.svg,
    required this.createdAt,
  });

  @override
  List<Object> get props => [
        id,
        name,
        icon,
        color,
        svg,
        createdAt,
      ];
}
