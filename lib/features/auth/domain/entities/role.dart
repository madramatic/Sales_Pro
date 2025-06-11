import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String userCount;

  const Role({
    required this.id,
    required this.name,
    required this.slug,
    required this.userCount,
  });

  @override
  List<Object> get props => [
        id,
        name,
        slug,
        userCount,
      ];
}
