import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../domain_layer/reddit_repository.dart';
import '../../models/listing_view_model.dart';

part 'new_event.dart';
part 'new_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class NewBloc extends Bloc<NewEvent, NewState> {
  final RedditRepository redditRepository;

  NewBloc({required this.redditRepository}) : super(const NewState()) {
    on<NewListingFetched>(_onNewListingFetched,
        transformer: throttleDroppable(throttleDuration));
    on<NewListingRefereshed>(_onHotLisingRefereshed,
        transformer: throttleDroppable(throttleDuration));
  }
  Future<void> _onNewListingFetched(
      NewListingFetched event, Emitter<NewState> emit) async {
    if (state.hasReachedMax == true) return;
    try {
      if (state.status == NewLisitingStatus.initail) {
        final hotLising = await redditRepository.getNewListing();
        final posts = hotLising.data.children
            .map((e) => ListingViewModel(
                  title: e.data.title,
                  postConent: e.data.getPostContent,
                  id: e.data.name,
                  postUrl: e.data.permalink,
                ))
            .toList();
        emit(state.copyWith(
          status: NewLisitingStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      } else {
        final hotLising = await redditRepository.getNewListing(
          after: state.posts.last.id,
        );
        final posts = hotLising.data.children
            .map((e) => ListingViewModel(
                  title: e.data.title,
                  postConent: e.data.getPostContent,
                  id: e.data.name,
                  postUrl: e.data.permalink,
                ))
            .toList();
        emit(posts.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                hasReachedMax: false,
                posts: List.of(state.posts)..addAll(posts),
                status: NewLisitingStatus.success,
              ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: NewLisitingStatus.failure,
      ));
    }
  }

  Future<void> _onHotLisingRefereshed(
      NewListingRefereshed event, Emitter<NewState> emit) async {
    emit(state.copyWith(
      status: NewLisitingStatus.initail,
      posts: [],
      hasReachedMax: false,
    ));
    try {
      final hotLising = await redditRepository.getNewListing();
      final posts = hotLising.data.children
          .map((e) => ListingViewModel(
                title: e.data.title,
                postConent: e.data.getPostContent,
                id: e.data.name,
                postUrl: e.data.permalink,
              ))
          .toList();
      emit(state.copyWith(
        status: NewLisitingStatus.success,
        posts: posts,
        hasReachedMax: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewLisitingStatus.failure,
        posts: [],
        hasReachedMax: false,
      ));
    }
  }
}
