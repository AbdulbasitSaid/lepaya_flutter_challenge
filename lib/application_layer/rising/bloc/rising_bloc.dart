import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../domain_layer/reddit_repository.dart';
import '../../models/listing_view_model.dart';

part 'rising_event.dart';
part 'rising_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class RisingBloc extends Bloc<RisingEvent, RisingState> {
  final RedditRepository redditRepository;

  RisingBloc({required this.redditRepository}) : super(const RisingState()) {
    on<RisingListingFetched>(_onRisingListingFetched,
        transformer: throttleDroppable(throttleDuration));
    on<RisingListingRefereshed>(_onRisingLisingRefereshed,
        transformer: throttleDroppable(throttleDuration));
  }
  Future<void> _onRisingListingFetched(
      RisingListingFetched event, Emitter<RisingState> emit) async {
    if (state.hasReachedMax == true) return;
    try {
      if (state.status == RisingLisitingStatus.initail) {
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
          status: RisingLisitingStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      } else {
        final hotLising = await redditRepository.getRisingListing(
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
                status: RisingLisitingStatus.success,
              ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: RisingLisitingStatus.failure,
      ));
    }
  }

  Future<void> _onRisingLisingRefereshed(
      RisingListingRefereshed event, Emitter<RisingState> emit) async {
    emit(state.copyWith(
      status: RisingLisitingStatus.initail,
      posts: [],
      hasReachedMax: false,
    ));
    try {
      final hotLising = await redditRepository.getRisingListing();
      final posts = hotLising.data.children
          .map((e) => ListingViewModel(
                title: e.data.title,
                postConent: e.data.getPostContent,
                id: e.data.name,
                postUrl: e.data.permalink,
              ))
          .toList();
      emit(state.copyWith(
        status: RisingLisitingStatus.success,
        posts: posts,
        hasReachedMax: false,
      ));
    } on Exception {
      emit(state.copyWith(
        status: RisingLisitingStatus.failure,
        posts: [],
        hasReachedMax: false,
      ));
    }
  }
}
