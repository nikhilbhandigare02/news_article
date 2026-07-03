import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Database/LocalStorageDao.dart';
import '../../Utils/enum.dart';
import '../../model/NewsArticleModel.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final LocalStorageDao _localStorageDao = LocalStorageDao.instance;

  BookmarkBloc() : super(const BookmarkState()) {
    on<LoadBookmarksEvent>(_loadBookmarks);
    on<AddBookmarkEvent>(_addBookmark);
    on<RemoveBookmarkEvent>(_removeBookmark);
    on<CheckBookmarkStatusEvent>(_checkBookmarkStatus);
  }

  Future<void> _loadBookmarks(
    LoadBookmarksEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(state.copyWith(status: BookmarkStatus.loading));
    try {
      final bookmarks = await _localStorageDao.getBookmarks();
      emit(
        state.copyWith(
          status: BookmarkStatus.success,
          bookmarks: bookmarks,
          actionStatus: BookmarkActionStatus.initial,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookmarkStatus.error,
          message: e.toString(),
          actionStatus: BookmarkActionStatus.initial,
        ),
      );
    }
  }

  Future<void> _addBookmark(
    AddBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    try {
      await _localStorageDao.insertBookmark(event.article);
      final bookmarks = await _localStorageDao.getBookmarks();
      emit(
        state.copyWith(
          bookmarks: bookmarks,
          actionStatus: BookmarkActionStatus.added,
          message: 'Article bookmarked',
          isCurrentArticleBookmarked: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: BookmarkActionStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _removeBookmark(
    RemoveBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    try {
      if (event.url != null) {
        await _localStorageDao.deleteBookmark(event.url!);
      }
      final bookmarks = await _localStorageDao.getBookmarks();
      emit(
        state.copyWith(
          bookmarks: bookmarks,
          actionStatus: BookmarkActionStatus.removed,
          message: 'Article removed from bookmarks',
          isCurrentArticleBookmarked: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: BookmarkActionStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _checkBookmarkStatus(
    CheckBookmarkStatusEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    if (event.url == null) return;
    try {
      final isBookmarked = await _localStorageDao.isBookmarked(event.url!);
      emit(
        state.copyWith(
          isCurrentArticleBookmarked: isBookmarked,
          actionStatus: BookmarkActionStatus.initial,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          actionStatus: BookmarkActionStatus.initial,
        ),
      );
    }
  }
}
