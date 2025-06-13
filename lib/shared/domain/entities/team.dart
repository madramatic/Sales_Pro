import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final int id;
  final String name;
  final String createdAt;

  const Team({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object> get props => [
        id,
        name,
        createdAt,
      ];
}
