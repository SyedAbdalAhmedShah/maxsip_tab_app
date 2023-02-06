abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingHomeState extends HomeState {}

class NoPermissionPhoneNumber extends HomeState {}

class StatusIsTransferout extends HomeState {}

class RedButtonPressed extends HomeState {}

class NoAccountFound extends HomeState {}

class SuccessfullyUserDataInserted extends HomeState {}

class FailureState extends HomeState {
  final String message;
  FailureState({required this.message});
}
