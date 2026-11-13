import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';

class ProductService {
  static const String apiUrl =
      'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data =
        jsonDecode(response.body);

        return data.map((item) {
          return Product.fromJson(
            item as Map<String, dynamic>,
          );
        }).toList();
      } else if (response.statusCode == 404) {
        throw Exception('Products not found (404)');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error (500)');
      } else {
        throw Exception(
          'Request failed: ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw Exception('Connection timeout. Try again.');
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
