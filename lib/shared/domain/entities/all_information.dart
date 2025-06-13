import 'package:equatable/equatable.dart';
import 'package:sales_pro/shared/domain/entities/interaction.dart';
import 'package:sales_pro/shared/domain/entities/organization.dart';
import 'package:sales_pro/shared/domain/entities/role.dart';
import 'package:sales_pro/shared/domain/entities/team.dart';

class AllInformation extends Equatable {
  final List<Team> teams;
  final List<Interaction> interactions;
  final List<Organization> organizations;
  final List<Role> roles;

  const AllInformation({
    required this.teams,
    required this.interactions,
    required this.organizations,
    required this.roles,
  });

  @override
  List<Object> get props => [
        teams,
        interactions,
        organizations,
        roles,
      ];
}
