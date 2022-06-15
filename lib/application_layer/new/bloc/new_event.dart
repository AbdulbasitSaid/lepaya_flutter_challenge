part of 'new_bloc.dart';

abstract class NewEvent extends Equatable {
  const NewEvent();

  @override
  List<Object> get props => [];
}

class NewListingFetched extends NewEvent {}

class NewListingRefereshed extends NewEvent {}
