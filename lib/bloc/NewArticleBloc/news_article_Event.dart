part of 'news_article_bloc.dart';
abstract class NewsArticleEvent extends Equatable{
const NewsArticleEvent();

List<Object> get props => [];
}

class fetchNewsArticleEvent extends NewsArticleEvent{
  final String category;
  const fetchNewsArticleEvent({required this.category});

  @override
  List<Object> get props => [category];
}