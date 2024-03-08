import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/data/repositories/auth_repo.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<UserExistsEvent>(userExistsevent);
  }

  FutureOr<void> userExistsevent(
    UserExistsEvent event, Emitter<OnboardingState> emit) async {
    emit(OnboardingLoadingState());

    String response = await AuthRepo().checkUser(phoneNumber: event.phoneNo);
    debugPrint('phoneNo: ${event.phoneNo}');
    debugPrint('response: $response');

    if (response == 'exists') {
      emit(OnboardingSuccessState());
    } else if (response == 'new user') {
      emit(OnboardingOTPState());
    } else {
      emit(OnBoardingErrorState());
    }
  }
}
