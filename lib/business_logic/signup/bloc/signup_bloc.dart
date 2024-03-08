import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/data/models/usermodel.dart';
import 'package:parkr/data/repositories/auth_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    // on<SigningUpEvent>();
  }

  FutureOr<void>signingupevent(SigningUpEvent event, Emitter<SignupState> emit) async{
    emit(SignUpLoadingState());

    String response = await AuthRepo().signupUser(usermodel: event.user,);
    debugPrint('response: $response');
    
    if(response=='success'){
      emit(SignUpSuccessState());
    }
    else if(response=='invalid-otp'){
      emit(SignupOTPErrorState());
    }
    else if(response=='Email/Phone No. Already Exists'){
      emit(UserExistsState());
    }
    else {
      emit(SignUpErrorState());
    }
  }
}
