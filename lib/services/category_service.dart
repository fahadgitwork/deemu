import 'package:dio/dio.dart';
import '../models/category.dart';

class CategoryService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://dummyjson.com';

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get('$_baseUrl/products/categories');
      final List<dynamic> data = response.data;
      return data.map((name) => Category.fromString(name.toString())).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<Category>> searchCategories(
    String query,
    List<Category> categories,
  ) async {
    query = query.toLowerCase();
    return categories
        .where(
          (category) =>
              category.name['name'].toString().toLowerCase().contains(query),
        )
        .toList();
  }
}
