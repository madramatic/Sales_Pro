import 'package:sales_pro/shared/domain/entities/organization.dart';

class OrganizationModel extends Organization {
  const OrganizationModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.status,
    required super.createdAt,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      status: json['status'] as bool,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'status': status,
      'created_at': createdAt,
    };
  }
}
