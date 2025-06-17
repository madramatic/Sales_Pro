import 'package:equatable/equatable.dart';
import 'package:sales_pro/shared/domain/entities/all_information.dart';

abstract class AllInformationState extends Equatable {
  const AllInformationState();

  @override
  List<Object> get props => [];
}

class AllInformationInitial extends AllInformationState {
  const AllInformationInitial();
}

class AllInformationLoading extends AllInformationState {
  const AllInformationLoading();
}

class AllInformationSuccess extends AllInformationState {
  final AllInformation allInformation;

  const AllInformationSuccess(this.allInformation);

  @override
  List<Object> get props => [allInformation];
}

class AllInformationFailure extends AllInformationState {
  final String message;

  const AllInformationFailure(this.message);

  @override
  List<Object> get props => [message];
}
