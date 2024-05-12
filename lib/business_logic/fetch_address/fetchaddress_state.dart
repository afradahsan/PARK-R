part of 'fetchaddress_bloc.dart';

sealed class FetchaddressState extends Equatable {
  const FetchaddressState();

  @override
  List<Object> get props => [];
}

final class FetchaddressInitial extends FetchaddressState {}

final class FetchaddressLoading extends FetchaddressState {}

final class FetchaddressSuccess extends FetchaddressState {
  final String address;
  const FetchaddressSuccess(this.address);

  @override
  List<Object> get props => [address];
}

final class FetchaddressError extends FetchaddressState {
  final String error;
  const FetchaddressError(this.error);

  @override
  List<Object> get props => [error];
}