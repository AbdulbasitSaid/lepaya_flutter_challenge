part of 'rising_bloc.dart';

abstract class RisingEvent extends Equatable {
  const RisingEvent();

  @override
  List<Object> get props => [];
}

class RisingListingFetched extends RisingEvent {}
class RisingListingRefereshed extends RisingEvent {}
