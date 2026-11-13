
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  int currentPage = 0;

  List<String> get galleryImages => [
    widget.product.imageUrl,
    widget.product.imageUrl,
    widget.product.imageUrl,
  ];

  void showShareSheet() {
    final link =
        'narxoz://store/product/${widget.product.id}';

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Share Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SelectableText(link),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: link),
                    );

                    if (!context.mounted) return;

                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text('Link copied!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy Deep Link'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: showShareSheet,
            icon: const Icon(Icons.share),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO + PHOTO CAROUSEL
            SizedBox(
              height: 320,
              child: PageView.builder(
                itemCount: galleryImages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Hero(
                    tag: 'product_image_${product.id}',
                    child: Image.network(
                      galleryImages[index],
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 80,
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            Center(
              child: Text(
                '${currentPage + 1} / ${galleryImages.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                galleryImages.length,
                    (index) {
                  return AnimatedContainer(
                    duration:
                    const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: currentPage == index ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CATEGORY
                  Chip(
                    label: Text(product.category),
                    backgroundColor: Colors.blue.shade100,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(
                        '${product.rating} / 5',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${product.reviewCount} reviews)',
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product added to cart!'),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Add to Cart'),
            ),
          ),
        ),
      ),
    );
  }
}
