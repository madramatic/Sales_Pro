import 'package:sales_pro/shared/data/models/interaction_model.dart';
import 'package:sales_pro/shared/data/models/organization_model.dart';
import 'package:sales_pro/shared/data/models/role_model.dart';
import 'package:sales_pro/shared/data/models/team_model.dart';
import 'package:sales_pro/shared/domain/entities/all_information.dart';

class AllInformationModel extends AllInformation {
  const AllInformationModel({
    required super.teams,
    required super.interactions,
    required super.organizations,
    required super.roles,
  });

  factory AllInformationModel.fromJson(Map<String, dynamic> json) {
    return AllInformationModel(
      teams: (json['teams'] as List<dynamic>)
          .map((team) => TeamModel.fromJson(team))
          .toList(),
      interactions: (json['interactions'] as List<dynamic>)
          .map((interaction) => InteractionModel.fromJson(interaction))
          .toList(),
      organizations: (json['organizations'] as List<dynamic>)
          .map((org) => OrganizationModel.fromJson(org))
          .toList(),
      roles: (json['roles'] as List<dynamic>)
          .map((role) => RoleModel.fromJson(role))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teams': teams.map((team) => (team as TeamModel).toJson()).toList(),
      'interactions': interactions
          .map((interaction) => (interaction as InteractionModel).toJson())
          .toList(),
      'organizations': organizations
          .map((org) => (org as OrganizationModel).toJson())
          .toList(),
      'roles': roles.map((role) => (role as RoleModel).toJson()).toList(),
    };
  }
}
