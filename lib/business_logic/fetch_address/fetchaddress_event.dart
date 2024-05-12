part of 'fetchaddress_bloc.dart';

sealed class FetchaddressEvent extends Equatable {
  const FetchaddressEvent();

  @override
  List<Object> get props => [];
}

class FetchEvent extends FetchaddressEvent{
  const FetchEvent();
}