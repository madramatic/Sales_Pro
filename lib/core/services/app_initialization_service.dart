import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_pro/features/auth/presentation/providers/auth_providers.dart';

class AppInitializationService {
  final Ref _ref;

  AppInitializationService(this._ref);

  Future<bool> initializeApp() async {
    try {
      final authRepository = _ref.read(authRepositoryProvider);
      final isLoggedInResult = await authRepository.isLoggedIn();

      return isLoggedInResult.fold(
        (failure) => false,
        (isLoggedIn) {
          if (isLoggedIn) {
            _ref
                .read(allInformationStateNotifierProvider.notifier)
                .getAllInformation();
          }
          return isLoggedIn;
        },
      );
    } catch (e) {
      return false;
    }
  }
}
