import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_articles/Repository/NewsArticleRepository.dart';

import '../../Utils/enum.dart';
import '../../model/NewsArticleModel.dart';

part 'news_article_Event.dart';
part 'news_article_state.dart';


class NewsArticleBloc extends Bloc<NewsArticleEvent, NewsArticleState>{
  Newsarticlerepository _newsarticlerepository = Newsarticlerepository();
  NewsArticleBloc(): super(NewsArticleState()){
    on<fetchNewsArticleEvent>(_fetchArticles);
  }

  Future<void> _fetchArticles(fetchNewsArticleEvent event, Emitter<NewsArticleState> emit)async{
    emit(state.copyWith(postApiStatus: PostApiStatus.initial));
    try{
      final response = await _newsarticlerepository.fetchNewsArticle(event.category);
      print(response);
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.success,
          articles: response.articles ?? [],
        ),

      );
    }catch(e){
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    }
  }
}