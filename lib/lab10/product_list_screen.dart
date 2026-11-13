import 'package:flutter/material.dart';

import 'product.dart';
import 'product_service.dart';
import 'product_card.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() =>
      _ProductListScreenState();
}

class _ProductListScreenState
    extends State<ProductListScreen> {
  final ProductService service = ProductService();

  List<Product> products = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await service.fetchProducts();

      if (!mounted) return;

      setState(() {
        products = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Product Explorer'),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_off,
                size: 65,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Connection Failed',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: loadProducts,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry Connection'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadProducts,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (context, index) =>
        const SizedBox(height: 4),
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
