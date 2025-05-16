import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/favorite_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  final Function(Product) onToggleFavorite;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    required this.onToggleFavorite,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductService _productService = ProductService();
  bool _isLoading = true;
  String? _error;
  Product? _product;

  @override
  void initState() {
    super.initState();
    _loadProductDetails();
  }

  Future<void> _loadProductDetails() async {
    try {
      final product = await _productService.getProductById(widget.productId);
      if (!mounted) return;
      setState(() {
        _product = product;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load product details';
        _isLoading = false;
      });
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _product?.title ?? 'Product Details',
          style: const TextStyle(fontFamily: 'Times New Roman', fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text(_error!))
              : _product == null
              ? const Center(child: Text('Product not found'))
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Product Image
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: _product!.images.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            _product!.images[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Details Header with Favorite Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Product Details',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Consumer<FavoriteService>(
                                builder: (context, favoriteService, child) {
                                  final isFavorite =
                                      _product != null &&
                                      favoriteService.isFavorite(_product!);
                                  return IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          isFavorite ? Colors.red : Colors.grey,
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      if (_product != null) {
                                        favoriteService.toggleFavorite(
                                          _product!,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Product Information
                          _buildInfoRow('Name', _product!.title),
                          _buildInfoRow(
                            'Price',
                            '\$${_product!.price.toStringAsFixed(2)}',
                          ),
                          _buildInfoRow(
                            'Category',
                            _product!.category ?? 'Uncategorized',
                          ),
                          _buildInfoRow('Brand', _product!.brand ?? 'Unknown'),

                          // Rating
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                const Text(
                                  'Rating: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _product!.rating.toStringAsFixed(1),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 8),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      size: 16,
                                      color:
                                          index < _product!.rating.floor()
                                              ? Colors.amber
                                              : Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          _buildInfoRow('Stock', _product!.stock.toString()),

                          const SizedBox(height: 16),
                          // Description
                          const Text(
                            'Description:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _product!.description ?? 'No description available',
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),

                          const SizedBox(height: 24),
                          // Product Gallery
                          const Text(
                            'Product Gallery:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1,
                                ),
                            itemCount: _product!.images.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                _product!.images[index],
                                fit: BoxFit.cover,
                              );
                            },
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
