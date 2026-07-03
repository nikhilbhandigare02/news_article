part of 'news_article_bloc.dart';

class NewsArticleState extends Equatable{
  final PostApiStatus postApiStatus;
  final List<Articles> articles;
  final String message;


  const NewsArticleState({
    this.postApiStatus = PostApiStatus.initial,
    this.message = '',
    this.articles = const [],
  });

  NewsArticleState copyWith({
     PostApiStatus? postApiStatus,
     List<Articles>? articles,
     String? message
}){
    return NewsArticleState(
      postApiStatus: postApiStatus ?? this.postApiStatus,
      articles: articles ?? this.articles,
      message: message ?? this.message
    );
  }

  List<Object?> get props => [articles, message, postApiStatus];
}
