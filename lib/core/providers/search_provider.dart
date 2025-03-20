import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/core/providers/products_provider.dart';

part 'search_provider.g.dart';

@riverpod
class Search extends _$Search {
  @override
  SearchState build() => const SearchState();

  void setQuery(String query) {
    state = state.copyWith(query: query);
    _updateResults();
  }

  void setMinPrice(double minPrice) {
    state = state.copyWith(minPrice: minPrice);
    _updateResults();
  }

  void setMaxPrice(double maxPrice) {
    state = state.copyWith(maxPrice: maxPrice);
    _updateResults();
  }

  void setCategory(String? category) {
    state = state.copyWith(category: category);
    _updateResults();
  }

  void _updateResults() {
    final products = ref.read(productsProvider);
    var results = products;

    // Apply search query filter
    if (state.query.isNotEmpty) {
      final lowercaseQuery = state.query.toLowerCase();
      results = results.where((product) {
        return product.name.toLowerCase().contains(lowercaseQuery) ||
            product.description.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }

    // Apply price range filter
    results = results.where((product) {
      return product.price >= state.minPrice && product.price <= state.maxPrice;
    }).toList();

    // Apply category filter
    if (state.category != null) {
      results = results.where((product) {
        return product.category == state.category;
      }).toList();
    }

    state = state.copyWith(results: results);
  }

  void clearFilters() {
    state = const SearchState();
    _updateResults();
  }
}

class SearchState {
  final String query;
  final double minPrice;
  final double maxPrice;
  final String? category;
  final List<Product> results;

  const SearchState({
    this.query = '',
    this.minPrice = 0.0,
    this.maxPrice = double.infinity,
    this.category,
    this.results = const [],
  });

  SearchState copyWith({
    String? query,
    double? minPrice,
    double? maxPrice,
    String? category,
    List<Product>? results,
  }) {
    return SearchState(
      query: query ?? this.query,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      category: category ?? this.category,
      results: results ?? this.results,
    );
  }
}
