import 'package:flutter/material.dart';
import 'dart:async';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../services/favorite_service.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Product> favoriteProducts;
  final Function(Product) onRemoveFromFavorites;

  const FavoritesScreen({
    super.key,
    required this.favoriteProducts,
    required this.onRemoveFromFavorites,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<Product> _filteredProducts = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.favoriteProducts;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchFavorites(_searchController.text);
    });
  }

  void _searchFavorites(String query) {
    setState(() {
      _isSearching = true;
      _filteredProducts =
          widget.favoriteProducts
              .where(
                (product) =>
                    product.title.toLowerCase().contains(query.toLowerCase()) ||
                    product.brand?.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ==
                        true ||
                    product.category?.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ==
                        true,
              )
              .toList();
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontFamily: 'Times New Roman', fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Consumer<FavoriteService>(
        builder: (context, favoriteService, child) {
          final favorites = favoriteService.favorites.toList();
          _filteredProducts =
              _searchController.text.isEmpty
                  ? favorites
                  : favorites
                      .where(
                        (product) =>
                            product.title.toLowerCase().contains(
                              _searchController.text.toLowerCase(),
                            ) ||
                            product.brand?.toLowerCase().contains(
                                  _searchController.text.toLowerCase(),
                                ) ==
                                true ||
                            product.category?.toLowerCase().contains(
                                  _searchController.text.toLowerCase(),
                                ) ==
                                true,
                      )
                      .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search favorites...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon:
                              _searchController.text.isNotEmpty
                                  ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {});
                                    },
                                  )
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${_filteredProducts.length} favorites found',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              Expanded(
                child:
                    _isSearching
                        ? const Center(child: CircularProgressIndicator())
                        : _filteredProducts.isEmpty
                        ? Center(
                          child: Text(
                            'No favorites found',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              color: Colors.white,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    product.images.isNotEmpty
                                        ? product.images.first
                                        : 'https://via.placeholder.com/60',
                                  ),
                                ),
                                title: Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          product.rating.toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Row(
                                          children: List.generate(
                                            5,
                                            (index) => Icon(
                                              Icons.star,
                                              size: 16,
                                              color:
                                                  index < product.rating.floor()
                                                      ? Colors.amber
                                                      : Colors.grey[300],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    favoriteService.removeFromFavorites(
                                      product,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          );
        },
      ),
    );
  }
}
