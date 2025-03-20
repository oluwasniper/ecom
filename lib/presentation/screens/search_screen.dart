import 'package:flutter/material.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/services/favorites_service.dart';
import 'package:ecom/presentation/screens/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FavoritesService _favoritesService = FavoritesService();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  RangeValues _priceRange = const RangeValues(0, 1000);
  bool _isLoading = false;

  final List<Product> _allProducts = [
    Product(
        id: '1',
        name: 'Nike Air Max',
        description: 'Classic sneakers',
        price: 129.99,
        category: 'Sneakers',
        imageUrl: 'https://picsum.photos/200'),
    Product(
        id: '2',
        name: 'Adidas Ultraboost',
        description: 'Running shoes',
        price: 179.99,
        category: 'Running',
        imageUrl: 'https://picsum.photos/201'),
    Product(
        id: '3',
        name: 'Puma RS-X',
        description: 'Retro sneakers',
        price: 99.99,
        category: 'Casual',
        imageUrl: 'https://picsum.photos/202'),
  ];

  List<Product> _filteredProducts = [];
  final List<String> _categories = [
    'All',
    'Sneakers',
    'Running',
    'Casual',
    'Sport'
  ];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final matchesQuery =
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                product.description
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase());
        final matchesCategory =
            _selectedCategory == 'All' || product.category == _selectedCategory;
        final matchesPrice = product.price >= _priceRange.start &&
            product.price <= _priceRange.end;
        return matchesQuery && matchesCategory && matchesPrice;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(isDark),
            _buildCategoryFilters(isDark, context),
            _buildPriceSlider(textColor),
            _buildProductGrid(textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
            _filterProducts();
          });
        },
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: isDark ? Colors.grey[900] : Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildCategoryFilters(bool isDark, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              selected: isSelected,
              label: Text(category),
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = selected ? category : 'All';
                  _filterProducts();
                });
              },
              backgroundColor: isDark ? Colors.grey[900] : Colors.grey[200],
              selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPriceSlider(Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: [
            Text(
                'Price Range: \$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                style: TextStyle(color: textColor))
          ]),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 1000,
            divisions: 20,
            labels: RangeLabels('\$${_priceRange.start.toInt()}',
                '\$${_priceRange.end.toInt()}'),
            onChanged: (values) {
              setState(() {
                _priceRange = values;
                _filterProducts();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(Color textColor) {
    return Expanded(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _filteredProducts.isEmpty
              ? _buildNoResults(textColor)
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) =>
                      _buildProductCard(_filteredProducts[index]),
                ),
    );
  }

  Widget _buildNoResults(Color textColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: textColor.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text('No products found',
              style:
                  TextStyle(fontSize: 18, color: textColor.withOpacity(0.5))),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product))),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  image: DecorationImage(
                      image: NetworkImage(product.imageUrl), fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
