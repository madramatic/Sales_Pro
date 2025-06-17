import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_pro/core/network/dio_client.dart';
import 'package:sales_pro/core/providers/all_infromation_storage_service_provider.dart';
import 'package:sales_pro/core/providers/secure_storage_service_provider.dart';
import 'package:sales_pro/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sales_pro/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sales_pro/features/auth/domain/usecases/get_all_information_usecase.dart';
import 'package:sales_pro/features/auth/presentation/providers/all_information_state.dart';
import 'package:sales_pro/features/auth/presentation/providers/all_information_state_notifier.dart';
import 'package:sales_pro/features/auth/presentation/providers/login_state.dart';
import 'package:sales_pro/shared/domain/entities/user.dart';
import 'package:sales_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:sales_pro/features/auth/domain/usecases/login_usecase.dart';
import 'package:sales_pro/features/auth/presentation/providers/login_state_notifier.dart';

// Data Source Provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return AuthRemoteDataSourceImpl(dioClient.instance);
});

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.read(authRemoteDataSourceProvider);
  final secureStorage = ref.read(secureStorageServiceProvider);
  final allInformationStorage = ref.read(allInformationStorageServiceProvider);
  return AuthRepositoryImpl(
    remoteDataSource,
    secureStorage,
    allInformationStorage,
  );
});

// Use Case Providers
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUseCase(repository);
});

final getAllInformationUseCaseProvider =
    Provider<GetAllInformationUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return GetAllInformationUseCase(repository);
});

// State Notifier Providers
final loginStateNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return LoginStateNotifier(loginUseCase);
});

final allInformationStateNotifierProvider =
    StateNotifierProvider<AllInformationStateNotifier, AllInformationState>(
        (ref) {
  final getAllInformationUseCase = ref.read(getAllInformationUseCaseProvider);
  return AllInformationStateNotifier(getAllInformationUseCase);
});

// Current User Provider
final currentUserProvider = StateProvider<User?>((ref) => null);
