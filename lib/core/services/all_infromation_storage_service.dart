import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sales_pro/shared/data/models/all_information_model.dart';
import 'package:sales_pro/shared/domain/entities/all_information.dart';
import 'package:sales_pro/shared/domain/entities/interaction.dart';
import 'package:sales_pro/shared/domain/entities/organization.dart';
import 'package:sales_pro/shared/domain/entities/role.dart';
import 'package:sales_pro/shared/domain/entities/team.dart';

class AllInformationStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _allInformationKey = 'all_information_data';
  static const String _lastFetchKey = 'all_information_last_fetch';

  // Cache duration: 1 hour
  static const Duration _cacheExpiry = Duration(hours: 1);

  Future<void> saveAllInformation(AllInformation allInformation) async {
    try {
      final model = AllInformationModel(
        teams: allInformation.teams,
        interactions: allInformation.interactions,
        organizations: allInformation.organizations,
        roles: allInformation.roles,
      );

      final jsonString = jsonEncode(model.toJson());
      await _storage.write(key: _allInformationKey, value: jsonString);
      await _storage.write(
        key: _lastFetchKey,
        value: DateTime.now().millisecondsSinceEpoch.toString(),
      );
    } catch (e) {
      throw Exception('Failed to save all information: ${e.toString()}');
    }
  }

  Future<AllInformation?> getAllInformation() async {
    try {
      final jsonString = await _storage.read(key: _allInformationKey);
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return AllInformationModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<bool> isCacheValid() async {
    try {
      final lastFetchString = await _storage.read(key: _lastFetchKey);
      if (lastFetchString == null) return false;

      final lastFetch = DateTime.fromMillisecondsSinceEpoch(
        int.parse(lastFetchString),
      );

      return DateTime.now().difference(lastFetch) < _cacheExpiry;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAllInformation() async {
    await _storage.delete(key: _allInformationKey);
    await _storage.delete(key: _lastFetchKey);
  }

  // Efficient lookups by ID
  Future<Team?> getTeamById(int id) async {
    final allInfo = await getAllInformation();
    if (allInfo == null) return null;

    try {
      return allInfo.teams.firstWhere((team) => team.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<Organization?> getOrganizationById(int id) async {
    final allInfo = await getAllInformation();
    if (allInfo == null) return null;

    try {
      return allInfo.organizations.firstWhere((org) => org.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<Role?> getRoleById(int id) async {
    final allInfo = await getAllInformation();
    if (allInfo == null) return null;

    try {
      return allInfo.roles.firstWhere((role) => role.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<Interaction?> getInteractionById(int id) async {
    final allInfo = await getAllInformation();
    if (allInfo == null) return null;

    try {
      return allInfo.interactions
          .firstWhere((interaction) => interaction.id == id);
    } catch (e) {
      return null;
    }
  }
}
