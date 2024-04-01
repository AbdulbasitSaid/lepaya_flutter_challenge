import 'package:equatable/equatable.dart';

class ListingViewModel extends Equatable {
  final String title;
  final String postConent;
  final String id;
  final String postUrl;

  const ListingViewModel({
    required this.title,
    required this.postConent,
    required this.id,
    required this.postUrl,
  });
  @override
  List<Object?> get props => [
        title,
        postConent,
        id,
        postUrl,
      ];
}
