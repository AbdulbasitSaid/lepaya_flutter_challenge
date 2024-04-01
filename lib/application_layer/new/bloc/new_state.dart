part of 'new_bloc.dart';

enum NewLisitingStatus { initail, success, failure }

class NewState extends Equatable {
  final NewLisitingStatus status;
  final List<ListingViewModel> posts;
  final bool hasReachedMax;
  final String message;

  const NewState({
    this.status = NewLisitingStatus.initail,
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
    return 'NewState(status: $status, posts: $posts, hasReachedMax: $hasReachedMax, message: $message)';
  }

  NewState copyWith({
    NewLisitingStatus? status,
    List<ListingViewModel>? posts,
    bool? hasReachedMax,
    String? message,
  }) {
    return NewState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
    );
  }
}
