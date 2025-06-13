import 'package:sales_pro/shared/domain/entities/team.dart';

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
    };
  }
}
