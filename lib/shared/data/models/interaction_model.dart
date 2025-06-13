import 'package:sales_pro/shared/domain/entities/interaction.dart';

class InteractionModel extends Interaction {
  const InteractionModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.color,
    required super.svg,
    required super.createdAt,
  });

  factory InteractionModel.fromJson(Map<String, dynamic> json) {
    return InteractionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
      svg: json['svg'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
      'svg': svg,
      'created_at': createdAt,
    };
  }
}
