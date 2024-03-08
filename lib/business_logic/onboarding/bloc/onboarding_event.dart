part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class UserExistsEvent extends OnboardingEvent{
  final String phoneNo;

  const UserExistsEvent({required this.phoneNo});
}