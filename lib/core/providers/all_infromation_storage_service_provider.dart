import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_pro/core/services/all_infromation_storage_service.dart';

final allInformationStorageServiceProvider =
    Provider<AllInformationStorageService>(
  (ref) => AllInformationStorageService(),
);
