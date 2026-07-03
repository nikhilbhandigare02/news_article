part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookmarksEvent extends BookmarkEvent {
  const LoadBookmarksEvent();
}

class AddBookmarkEvent extends BookmarkEvent {
  final Articles article;

  const AddBookmarkEvent({required this.article});

  @override
  List<Object?> get props => [article];
}

class RemoveBookmarkEvent extends BookmarkEvent {
  final String? url;
  final int? index;

  const RemoveBookmarkEvent({this.url, this.index});

  @override
  List<Object?> get props => [url, index];
}

class CheckBookmarkStatusEvent extends BookmarkEvent {
  final String? url;

  const CheckBookmarkStatusEvent({this.url});

  @override
  List<Object?> get props => [url];
}
