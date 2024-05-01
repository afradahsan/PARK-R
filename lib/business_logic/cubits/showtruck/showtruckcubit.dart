import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/utils/constants.dart';

class ShowTruckCubit extends Cubit<bool>{
  ShowTruckCubit() : super(false);

  Widget show(BuildContext context){
    emit(!state);
    return sizedfive(context);
  }
}