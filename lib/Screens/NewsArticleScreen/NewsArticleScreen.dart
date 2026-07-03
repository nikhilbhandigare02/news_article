import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_articles/Routes/RouteName.dart';
import 'package:news_articles/Widgets/AppBar.dart';
import 'package:news_articles/bloc/NewArticleBloc/news_article_bloc.dart';

import '../../Utils/enum.dart';
import '../../model/NewsArticleModel.dart';

class NewsArticleScreen extends StatefulWidget {
  final String category;
  const NewsArticleScreen({super.key, required this.category});

  @override
  State<NewsArticleScreen> createState() => _NewsArticleScreenState();
}

class _NewsArticleScreenState extends State<NewsArticleScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // context.read<NewsArticleBloc>().add(fetchNewsArticleEvent(category: widget.category));

  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Articles> _filterArticles(List<Articles> articles, String query) {
    if (query.isEmpty) {
      return articles;
    }
    final lowerQuery = query.toLowerCase();
    return articles.where((article) {
      final title = article.title?.toLowerCase() ?? '';
      final description = article.description?.toLowerCase() ?? '';
      final sourceName = article.source?.name?.toLowerCase() ?? '';
      return title.contains(lowerQuery) ||
          description.contains(lowerQuery) ||
          sourceName.contains(lowerQuery);
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewsAppBar(
        title: widget.category,
        showBack: true,
      ),
      body: BlocProvider(
        create: (_) => NewsArticleBloc()
          ..add(
            fetchNewsArticleEvent(
              category: widget.category,
            ),
          ),child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<NewsArticleBloc, NewsArticleState>(
              builder: (context, state) {
                if (state.postApiStatus == PostApiStatus.initial ||
                    state.postApiStatus == PostApiStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF2D6CDF),
                    ),
                  );
                } else if (state.postApiStatus == PostApiStatus.error) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.wifi_off_rounded, size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'Unable to load news',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final filteredArticles = _filterArticles(state.articles, _searchQuery);

                if (filteredArticles.isEmpty) {
                  return Center(
                    child: Text(
                      _searchQuery.isEmpty ? 'No articles found' : 'No articles match your search',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                    ),
                  );
                } else {
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) {
                        final article = filteredArticles[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routename.ArticleDetails,
                              arguments: {'article': article},
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                color: Colors.orange,
                                width: 0.05,
                              ),),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: article.urlToImage != null
                                        ? Image.network(
                                      article.urlToImage!,
                                      width: 110,
                                      height: 110,
                                      fit: BoxFit.cover,

                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 110,
                                          height: 110,
                                          color: const Color(0xFFF2F4F8),
                                          child: const Icon(
                                            Icons.broken_image_outlined,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                        );
                                      },
                                    )
                                        : Container(
                                      width: 110,
                                      height: 110,
                                      color: Colors.grey.shade200,
                                      child: const Icon(Icons.image),
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade50,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            article.source?.name ?? "News",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.blue.shade700,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 8),


                                        Text(
                                          article.title ?? "No title",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            height: 1.3,
                                          ),
                                        ),

                                        const SizedBox(height: 10),


                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_rounded,
                                              size: 14,
                                              color: Colors.grey.shade500,
                                            ),
                                            const SizedBox(width: 5),

                                            Expanded(
                                              child: Text(
                                                article.publishedAt != null
                                                    ? DateFormat('dd-MM-yyyy').format(
                                                  DateTime.parse(article.publishedAt!),
                                                )
                                                    : "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ),

                                            Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade50,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 12,
                                                color: Colors.blue.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                }
              },
            ),
          ),
        ],
      ),)
    );
  }
}