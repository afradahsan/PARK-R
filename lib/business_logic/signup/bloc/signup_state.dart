part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();
  
  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

class SignUpLoadingState extends SignupState {}

class SignUpSuccessState extends SignupState {}

class SignUpTryAgainState extends SignupState {}

class SignUpErrorState extends SignupState {}