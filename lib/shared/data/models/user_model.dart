import 'package:sales_pro/shared/data/models/organization_model.dart';
import 'package:sales_pro/shared/data/models/role_model.dart';
import 'package:sales_pro/shared/data/models/team_model.dart';
import 'package:sales_pro/shared/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.isSuperAdmin,
    required super.status,
    required super.manageOwnTeam,
    required super.appLogin,
    super.avatar,
    super.organization,
    super.team,
    required super.organizations,
    required super.teams,
    required super.role,
    required super.phone,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      isSuperAdmin: json['isSuperAdmin'] as bool,
      status: json['status'] as bool,
      manageOwnTeam: json['manage_own_team'] as bool,
      appLogin: json['app_login'] as bool,
      avatar: json['avatar'] as String?,
      organization: json['organization'] != null
          ? OrganizationModel.fromJson(json['organization'])
          : null,
      team: json['team'] != null ? TeamModel.fromJson(json['team']) : null,
      organizations: (json['organizations'] as List<dynamic>)
          .map((org) => OrganizationModel.fromJson(org))
          .toList(),
      teams: (json['teams'] as List<dynamic>)
          .map((team) => TeamModel.fromJson(team))
          .toList(),
      role: RoleModel.fromJson(json['role']),
      phone: json['phone'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'isSuperAdmin': isSuperAdmin,
      'status': status,
      'manage_own_team': manageOwnTeam,
      'app_login': appLogin,
      'avatar': avatar,
      'organization': organization != null
          ? (organization as OrganizationModel).toJson()
          : null,
      'team': team != null ? (team as TeamModel).toJson() : null,
      'organizations': organizations
          .map((org) => (org as OrganizationModel).toJson())
          .toList(),
      'teams': teams.map((team) => (team as TeamModel).toJson()).toList(),
      'role': (role as RoleModel).toJson(),
      'phone': phone,
      'created_at': createdAt,
    };
  }
}
