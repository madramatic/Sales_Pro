import 'package:equatable/equatable.dart';

class Organization extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String status;
  final String createdAt;

  const Organization({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object> get props => [
        id,
        name,
        slug,
        status,
        createdAt,
      ];
}
