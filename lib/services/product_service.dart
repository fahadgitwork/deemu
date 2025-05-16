import 'package:dio/dio.dart';
import '../models/product.dart';

class ProductService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://dummyjson.com';

  Future<ProductResponse> getProducts() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/products',
        queryParameters: {'limit': 20},
      );
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<ProductResponse> searchProducts(String query) async {
    try {
      if (query.trim().isEmpty) {
        return getProducts();
      }

      final response = await _dio.get(
        '$_baseUrl/products/search',
        queryParameters: {'q': query, 'limit': 20},
      );
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/products/$id');
      return Product.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load product details: $e');
    }
  }
}
