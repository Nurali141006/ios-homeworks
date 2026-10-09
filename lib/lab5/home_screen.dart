import 'package:flutter/material.dart';
import 'package:my_project/lab5/widgets/product_tag.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Air Runner',
      'price': 45000,
      'category': 'Running',
      'rating': 4.8,
      'image':
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
    },
    {
      'name': 'Urban Classic',
      'price': 38000,
      'category': 'Casual',
      'rating': 4.6,
      'image':
      'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=800',
    },
    {
      'name': 'Sport Pro',
      'price': 52000,
      'category': 'Sport',
      'rating': 4.9,
      'image':
      'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=800',
    },
  ];

  final List<String> categories = ['All', 'Running', 'Casual', 'Sport'];
  final Set<String> favorites = {};
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final shownProducts = selectedCategory == 'All'
        ? products
        : products.where((p) => p['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SNEAKER STORE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find your style.',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Discover sneakers for every day.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 8,
            children: categories.map((category) {
              return ChoiceChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (_) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          const Text(
            'Popular sneakers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          ...shownProducts.map((product) {
            final String name = product['name'];

            return ProductCard(
              product: product,
              isFavorite: favorites.contains(name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: product),
                  ),
                );
              },
              onFavorite: () {
                setState(() {
                  if (favorites.contains(name)) {
                    favorites.remove(name);
                  } else {
                    favorites.add(name);
                  }
                });
              },
            );
          }),
        ],
      ),
    );
  }
}
