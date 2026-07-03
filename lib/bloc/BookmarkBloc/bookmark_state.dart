part of 'bookmark_bloc.dart';



class BookmarkState extends Equatable {
  final BookmarkStatus status;
  final BookmarkActionStatus actionStatus;
  final List<Articles> bookmarks;
  final String message;
  final bool isCurrentArticleBookmarked;

  const BookmarkState({
    this.status = BookmarkStatus.initial,
    this.actionStatus = BookmarkActionStatus.initial,
    this.bookmarks = const [],
    this.message = '',
    this.isCurrentArticleBookmarked = false,
  });

  BookmarkState copyWith({
    BookmarkStatus? status,
    BookmarkActionStatus? actionStatus,
    List<Articles>? bookmarks,
    String? message,
    bool? isCurrentArticleBookmarked,
  }) {
    return BookmarkState(
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
      bookmarks: bookmarks ?? this.bookmarks,
      message: message ?? this.message,
      isCurrentArticleBookmarked:
          isCurrentArticleBookmarked ?? this.isCurrentArticleBookmarked,
    );
  }

  @override
  List<Object?> get props => [
        status,
        actionStatus,
        bookmarks,
        message,
        isCurrentArticleBookmarked,
      ];
}
