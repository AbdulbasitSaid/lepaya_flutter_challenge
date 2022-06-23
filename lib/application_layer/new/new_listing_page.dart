import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_loader_widget.dart';
import '../widgets/post_list_item_widget.dart';
import 'bloc/new_bloc.dart';

class NewListingPage extends StatefulWidget {
  const NewListingPage({Key? key}) : super(key: key);

  @override
  State<NewListingPage> createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<NewBloc>().add(NewListingFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewBloc, NewState>(
      builder: (BuildContext context, state) {
        switch (state.status) {
          case NewLisitingStatus.failure:
            return Center(
                child: TextButton(
                    onPressed: () {
                      context.read<NewBloc>().add(NewListingRefereshed());
                    },
                    child: const Text(
                        'failed to fetch posts please pull to refesh')));
          case NewLisitingStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              color: const Color(0xffF6F6F6),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<NewBloc>().add(NewListingRefereshed());
                },
                child: ListView.separated(
                  key: const Key('new-listview'),
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.posts.length
                        ? const BottomLoader()
                        : PostListItem(
                            post: state.posts[index],
                            key: Key(state.posts[index].id),
                          );
                  },
                  itemCount: state.hasReachedMax == true
                      ? state.posts.length
                      : state.posts.length + 1,
                  controller: _scrollController,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                ),
              ),
            );
          default:
            return const BottomLoader();
        }
      },
    );
  }
}
