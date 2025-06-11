import 'package:equatable/equatable.dart';
import 'package:sales_pro/features/auth/domain/entities/organization.dart';
import 'package:sales_pro/features/auth/domain/entities/role.dart';
import 'package:sales_pro/features/auth/domain/entities/team.dart';

class User extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isSuperAdmin;
  final bool status;
  final bool manageOwnTeam;
  final bool appLogin;
  final String? avatar;
  final Organization? organization;
  final Team? team;
  final List<Organization> organizations;
  final List<Team> teams;
  final Role role;
  final String phone;
  final String createdAt;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isSuperAdmin,
    required this.status,
    required this.manageOwnTeam,
    required this.appLogin,
    this.avatar,
    this.organization,
    this.team,
    required this.organizations,
    required this.teams,
    required this.role,
    required this.phone,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        isSuperAdmin,
        status,
        manageOwnTeam,
        appLogin,
        avatar,
        organization,
        team,
        organizations,
        teams,
        role,
        phone,
        createdAt,
      ];
}
