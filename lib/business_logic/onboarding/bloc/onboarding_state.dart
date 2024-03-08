part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();
  
  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoadingState extends OnboardingState{}

final class OnboardingSuccessState extends OnboardingState{}

final class OnboardingOTPState extends OnboardingState{}

final class OnBoardingErrorState extends OnboardingState{}