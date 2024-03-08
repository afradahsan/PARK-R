part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SigningUpEvent extends SignupEvent{
  final UserModel user;

  const SigningUpEvent({required this.user});
}