import 'package:flutter/material.dart';

void main() {
  runApp(const SmartCatalogApp());
}

class SmartCatalogApp extends StatelessWidget {
  const SmartCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Catalog & Infinite Feed',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const SmartCatalogScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Product {
  final String id;
  final String title;
  final String category;
  final double rating;
  final double price;
  final IconData icon;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.rating,
    required this.price,
    required this.icon,
  });
}

class SmartCatalogScreen extends StatefulWidget {
  const SmartCatalogScreen({super.key});

  @override
  State<SmartCatalogScreen> createState() => _SmartCatalogScreenState();
}

class _SmartCatalogScreenState extends State<SmartCatalogScreen> {
  bool _isGridView = false;

  final List<Product> _initialProducts = [
    Product(id: '1', title: 'Wireless Headphones', category: 'Audio', rating: 4.5, price: 59.99, icon: Icons.headphones),
    Product(id: '2', title: 'Smart Watch Series 5', category: 'Wearables', rating: 4.8, price: 199.99, icon: Icons.watch),
    Product(id: '3', title: 'Ergonomic Mouse', category: 'Accessories', rating: 4.2, price: 29.99, icon: Icons.mouse),
    Product(id: '4', title: 'Mechanical Keyboard', category: 'Accessories', rating: 4.7, price: 89.99, icon: Icons.keyboard),
    Product(id: '5', title: 'Portable Power Bank', category: 'Power', rating: 4.4, price: 45.00, icon: Icons.bolt),
  ];

  late List<Product> _products;

  @override
  void initState() {
    super.initState();
    _products = List.from(_initialProducts);
  }
  void _resetCatalog() {
    setState(() {
      _products = List.from(_initialProducts);
    });
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      final newId = DateTime.now().millisecondsSinceEpoch.toString();
      _products.insert(
        0,
        Product(
          id: newId,
          title: 'New Featured Item #${_products.length + 1}',
          category: 'Promoted',
          rating: 5.0,
          price: 39.99,
          icon: Icons.star,
        ),
      );
    });
  }

  void _removeItem(int index) {
    final removedProduct = _products[index];
    setState(() {
      _products.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedProduct.title} removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _products.insert(index, removedProduct);
            });
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Catalog & Feed'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            tooltip: 'Toggle View Mode',
          ),
        ],
      ),
      body: _products.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.remove_shopping_cart, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Catalog is Empty',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _resetCatalog,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Catalog'),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: _handleRefresh,
        child: _isGridView ? _buildGrid() : _buildList(),
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      itemCount: _products.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final product = _products[index];
        return Dismissible(
          key: ValueKey(product.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) => _removeItem(index),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.shade50,
              child: Icon(product.icon, color: Colors.deepPurple),
            ),
            title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${product.category} • ⭐ ${product.rating}'),
            trailing: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Dismissible(
          key: ValueKey(product.id),
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) => _removeItem(index),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.deepPurple.shade50,
                      child: Icon(product.icon, size: 32, color: Colors.deepPurple),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(product.category, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('⭐ ${product.rating}', style: const TextStyle(fontSize: 12)),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}