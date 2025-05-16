import 'package:flutter/foundation.dart';
import '../models/product.dart';

class FavoriteService extends ChangeNotifier {
  final Set<Product> _favorites = {};

  Set<Product> get favorites => _favorites;

  bool isFavorite(Product product) {
    return _favorites.contains(product);
  }

  void toggleFavorite(Product product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  void removeFromFavorites(Product product) {
    _favorites.remove(product);
    notifyListeners();
  }
}
