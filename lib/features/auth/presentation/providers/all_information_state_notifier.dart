import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_pro/features/auth/domain/usecases/get_all_information_usecase.dart';
import 'package:sales_pro/features/auth/presentation/providers/all_information_state.dart';

class AllInformationStateNotifier extends StateNotifier<AllInformationState> {
  final GetAllInformationUseCase _getAllInformationUseCase;

  AllInformationStateNotifier(this._getAllInformationUseCase)
      : super(const AllInformationInitial());

  Future<void> getAllInformation() async {
    state = const AllInformationLoading();

    final result = await _getAllInformationUseCase();

    result.fold(
      (failure) => state = AllInformationFailure(failure.message),
      (allInformation) => state = AllInformationSuccess(allInformation),
    );
  }

  void resetState() {
    state = const AllInformationInitial();
  }
}
