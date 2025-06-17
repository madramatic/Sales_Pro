import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_pro/core/services/app_initialization_service.dart';

final appInitializationServiceProvider =
    Provider<AppInitializationService>((ref) {
  return AppInitializationService(ref);
});
