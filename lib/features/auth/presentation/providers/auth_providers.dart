import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_pro/core/network/dio_client.dart';
import 'package:sales_pro/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sales_pro/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sales_pro/features/auth/domain/entities/user.dart';
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
  return AuthRepositoryImpl(remoteDataSource);
});

// Use Case Provider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUseCase(repository);
});

// State Notifier Provider
final loginStateNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return LoginStateNotifier(loginUseCase);
});

// Current User Provider (for future use)
final currentUserProvider = StateProvider<User?>((ref) => null);
