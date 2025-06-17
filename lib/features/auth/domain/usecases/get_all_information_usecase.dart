import 'package:sales_pro/core/utils/typedef.dart';
import 'package:sales_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:sales_pro/shared/domain/entities/all_information.dart';

class GetAllInformationUseCase {
  final AuthRepository _repository;

  const GetAllInformationUseCase(this._repository);

  ResultFuture<AllInformation> call() async {
    return await _repository.getAllInformation();
  }
}
