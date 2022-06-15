part of 'hot_bloc.dart';

enum HotLisitingStatus { initail, success, failure }

class HotState extends Equatable {
  final HotLisitingStatus status;
  final List<ListingViewModel> posts;
  final bool hasReachedMax;
  final String message;

  const HotState({
    this.status = HotLisitingStatus.initail,
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
    return 'HotState(status: $status, posts: $posts, hasReachedMax: $hasReachedMax, message: $message)';
  }

  HotState copyWith({
    HotLisitingStatus? status,
    List<ListingViewModel>? posts,
    bool? hasReachedMax,
    String? message,
  }) {
    return HotState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
    );
  }
}
