part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigningInEvent extends SigninEvent{
  final String password;
  final String phoneNo;

  const SigningInEvent({required this.password, required this.phoneNo});
}