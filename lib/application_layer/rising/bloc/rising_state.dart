part of 'rising_bloc.dart';

enum RisingLisitingStatus { initail, success, failure }

class RisingState extends Equatable {
  final RisingLisitingStatus status;
  final List<ListingViewModel> posts;
  final bool hasReachedMax;
  final String message;

  const RisingState({
    this.status = RisingLisitingStatus.initail,
    this.posts = const <ListingViewModel>[],
    this.hasReachedMax = false,
    this.message = '',
  });
  @override
  List<Object?> get props => [
        status,
        posts,
        hasReachedMax,
        message,
      ];

  @override
  String toString() {
    return 'RisingState(status: $status, posts: $posts, hasReachedMax: $hasReachedMax, message: $message)';
  }

  RisingState copyWith({
    RisingLisitingStatus? status,
    List<ListingViewModel>? posts,
    bool? hasReachedMax,
    String? message,
  }) {
    return RisingState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
    );
  }
}
