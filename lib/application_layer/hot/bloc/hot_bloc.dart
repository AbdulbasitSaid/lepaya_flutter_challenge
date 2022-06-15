import 'package:equatable/equatable.dart';
import 'package:flutter_assignment/application_layer/models/listing_view_model.dart';
import 'package:flutter_assignment/domain_layer/reddit_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'hot_event.dart';
part 'hot_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HotBloc extends Bloc<HotEvent, HotState> {
  final RedditRepository redditRepository;
  HotBloc({required this.redditRepository}) : super(const HotState()) {
    on<HotListingFetched>(_onHotListingFetched,
        transformer: throttleDroppable(throttleDuration));
    on<HotListingRefereshed>(_onHotLisingRefereshed,
        transformer: throttleDroppable(throttleDuration));
  }
  Future<void> _onHotListingFetched(
      HotListingFetched event, Emitter<HotState> emit) async {
    if (state.hasReachedMax == true) return;
    try {
      if (state.status == HotLisitingStatus.initail) {
        final hotLising = await redditRepository.getHotListing();
        final posts = hotLising.data.children
            .map((e) => ListingViewModel(
                  title: e.data.title,
                  postConent: e.data.getPostContent,
                  id: e.data.name,
                  postUrl: e.data.permalink,
                ))
            .toList();
        emit(state.copyWith(
          status: HotLisitingStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      } else {
        final hotLising = await redditRepository.getHotListing(
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
                status: HotLisitingStatus.success,
              ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HotLisitingStatus.failure,
      ));
    }
  }

  Future<void> _onHotLisingRefereshed(
      HotListingRefereshed event, Emitter<HotState> emit) async {
    emit(state.copyWith(
      status: HotLisitingStatus.initail,
      posts: [],
      hasReachedMax: false,
    ));
    try {
      final hotLising = await redditRepository.getHotListing();
      final posts = hotLising.data.children
          .map((e) => ListingViewModel(
                title: e.data.title,
                postConent: e.data.getPostContent,
                id: e.data.name,
                postUrl: e.data.permalink,
              ))
          .toList();
      emit(state.copyWith(
        status: HotLisitingStatus.success,
        posts: posts,
        hasReachedMax: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HotLisitingStatus.failure,
      ));
    }
  }
}
