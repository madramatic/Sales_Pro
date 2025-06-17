import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_pro/core/providers/all_infromation_storage_service_provider.dart';
import 'package:sales_pro/core/services/all_infromation_storage_service.dart';
import 'package:sales_pro/shared/domain/entities/interaction.dart';
import 'package:sales_pro/shared/domain/entities/organization.dart';
import 'package:sales_pro/shared/domain/entities/role.dart';
import 'package:sales_pro/shared/domain/entities/team.dart';
import 'package:sales_pro/shared/domain/entities/all_information.dart';
import 'package:sales_pro/features/auth/presentation/providers/auth_providers.dart';
import 'package:sales_pro/features/auth/presentation/providers/all_information_state.dart';

class AllInformationService {
  final AllInformationStorageService _storageService;
  final Ref _ref;

  AllInformationService(this._storageService, this._ref);

  //? Get current all information from state or storage
  AllInformation? get currentAllInformation {
    final state = _ref.read(allInformationStateNotifierProvider);
    if (state is AllInformationSuccess) {
      return state.allInformation;
    }
    return null;
  }

  // Efficient lookups with fallback to storage
  Future<Team?> getTeamById(int id) async {
    final current = currentAllInformation;
    if (current != null) {
      try {
        return current.teams.firstWhere((team) => team.id == id);
      } catch (e) {
        // Not found in current state
      }
    }

    // Fallback to storage
    return await _storageService.getTeamById(id);
  }

  Future<Organization?> getOrganizationById(int id) async {
    final current = currentAllInformation;
    if (current != null) {
      try {
        return current.organizations.firstWhere((org) => org.id == id);
      } catch (e) {
        // Not found in current state
      }
    }

    // Fallback to storage
    return await _storageService.getOrganizationById(id);
  }

  Future<Role?> getRoleById(int id) async {
    final current = currentAllInformation;
    if (current != null) {
      try {
        return current.roles.firstWhere((role) => role.id == id);
      } catch (e) {
        // Not found in current state
      }
    }

    // Fallback to storage
    return await _storageService.getRoleById(id);
  }

  Future<Interaction?> getInteractionById(int id) async {
    final current = currentAllInformation;
    if (current != null) {
      try {
        return current.interactions
            .firstWhere((interaction) => interaction.id == id);
      } catch (e) {
        // Not found in current state
      }
    }

    // Fallback to storage
    return await _storageService.getInteractionById(id);
  }

  // Get all teams
  List<Team> get allTeams {
    final current = currentAllInformation;
    return current?.teams ?? [];
  }

  // Get all organizations
  List<Organization> get allOrganizations {
    final current = currentAllInformation;
    return current?.organizations ?? [];
  }

  // Get all roles
  List<Role> get allRoles {
    final current = currentAllInformation;
    return current?.roles ?? [];
  }

  // Get all interactions
  List<Interaction> get allInteractions {
    final current = currentAllInformation;
    return current?.interactions ?? [];
  }

  // Refresh data
  Future<void> refreshAllInformation() async {
    _ref.read(allInformationStateNotifierProvider.notifier).getAllInformation();
  }
}

final allInformationServiceProvider = Provider<AllInformationService>((ref) {
  final storageService = ref.read(allInformationStorageServiceProvider);
  return AllInformationService(storageService, ref);
});
