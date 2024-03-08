import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/data/repositories/auth_repo.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<SigningInEvent>(signinevent);
  }
  FutureOr<void> signinevent(
      SigningInEvent event, Emitter<SigninState> emit) async {
    emit(SigninLoadingState());

    String response = await AuthRepo()
        .signinUser(phone: event.phoneNo, password: event.password);

    if (response == 'success') {
      emit(SigninSuccessState());
    } else {
      SigninErrorState();
    }
  }
}