import 'package:flutter/material.dart';

void main() {
  runApp(const NewsApp());
}

class NewsArticle {
  final String title;
  final String description;
  final String image;
  final String category;
  final String date;

  const NewsArticle({
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.date,
  });
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<NewsArticle> articles = [
    const NewsArticle(
      title: 'Artificial Intelligence',
      description:
      'Artificial intelligence is changing the world. '
          'It helps people learn, work, and solve problems faster.',
      image:
      'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800',
      category: 'Technology',
      date: 'October 14, 2026',
    ),
    const NewsArticle(
      title: 'Football News',
      description:
      'Football fans are waiting for exciting matches. '
          'Teams are preparing for the next big games.',
      image:
      'https://images.unsplash.com/photo-1522778119026-d647f0596c20?w=800',
      category: 'Sports',
      date: 'October 13, 2026',
    ),
    const NewsArticle(
      title: 'Modern Education',
      description:
      'Online learning and digital tools give students '
          'more ways to study and improve their knowledge.',
      image:
      'https://images.unsplash.com/photo-1501504905252-473c47e087f8?w=800',
      category: 'Education',
      date: 'October 12, 2026',
    ),
    const NewsArticle(
      title: 'Travel and Nature',
      description:
      'Travel helps people discover new places, '
          'experience different cultures, and enjoy nature.',
      image:
      'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800',
      category: 'Travel',
      date: 'October 11, 2026',
    ),
  ];

  final List<NewsArticle> favorites = [];

  void toggleFavorite(NewsArticle article) {
    setState(() {
      if (favorites.contains(article)) {
        favorites.remove(article);
      } else {
        favorites.add(article);
      }
    });
  }

  void openDetails(NewsArticle article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          article: article,
          isFavorite: favorites.contains(article),
          onFavoritePressed: () => toggleFavorite(article),
        ),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      buildFeed(),
      buildFavorites(),
      buildProfile(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildFeed() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => openDetails(article),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  article.image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 180,
                      child: Center(
                        child: Icon(Icons.image_not_supported, size: 50),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.category,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(article.date),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            favorites.contains(article)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () => toggleFavorite(article),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildFavorites() {
    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'No favorite articles yet',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final article = favorites[index];

        return Card(
          child: ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: Text(article.title),
            subtitle: Text(article.category),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => openDetails(article),
          ),
        );
      },
    );
  }

  Widget buildProfile() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 55),
            ),
            const SizedBox(height: 16),
            const Text(
              'News App User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('student@example.com'),
            const SizedBox(height: 24),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              subtitle: Text('App preferences'),
            ),
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              subtitle: Text('News App - Lab Assignment 7'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final NewsArticle article;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const DetailScreen({
    super.key,
    required this.article,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              widget.onFavoritePressed();
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 250,
                  child: Center(
                    child: Icon(Icons.image_not_supported, size: 60),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.category,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.date,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    article.description,
                    style: const TextStyle(fontSize: 17, height: 1.6),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back to Feed'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
