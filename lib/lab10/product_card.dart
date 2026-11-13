import 'package:flutter/material.dart';
import 'product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),
        leading: Hero(
          tag: 'product_image_${product.id}',
          child: Image.network(
            product.imageUrl,
            width: 75,
            height: 75,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image_not_supported);
            },
          ),
        ),
        title: Text(
          product.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text('\$${product.price.toStringAsFixed(2)}'),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 18,
                ),
                Text(
                  '${product.rating} (${product.reviewCount})',
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
