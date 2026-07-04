import 'package:flutter/material.dart';

import '../../Routes/RouteName.dart';
import '../../Widgets/AppBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  final List<CategoryModel> categories = [
    CategoryModel(name: "Entertainment", icon: Icons.movie, color: Colors.pink, ),
    CategoryModel(name: "Business", icon: Icons.business, color: Colors.blue, ),
    CategoryModel(name: "Sports", icon: Icons.sports_cricket, color: Colors.green, ),
    CategoryModel(name: "General", icon: Icons.public, color: Colors.orange,),
    CategoryModel(name: "Technology", icon: Icons.memory, color: Colors.deepPurple, ),
    CategoryModel(name: "Science", icon: Icons.science, color: Colors.teal, ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewsAppBar(
        title: "News Category",
        showBack: false,
        moreIcon: Icons.bookmark_border_rounded,
        onMorePressed: () {
          Navigator.pushNamed(context, Routename.BookmarkScreen);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final item = categories[index];

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routename.NewsArticle,
                  arguments: {'category': item.name},
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.orange, width: 0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: item.color.withOpacity(0.2),
                        radius: 28,
                        child: Icon(item.icon, color: item.color, size: 28),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 10),


                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryModel {
  final String name;
  final IconData icon;
  final Color color;


  CategoryModel({
    required this.name,
    required this.icon,
    required this.color,

  });
}