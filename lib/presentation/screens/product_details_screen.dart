import 'package:flutter/material.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/services/favorites_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final FavoritesService _favoritesService = FavoritesService();
  bool _isFavorite = false;
  String? _selectedSize;
  Color? _selectedColor;
  int _quantity = 1;

  final List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<Color> _colors = [
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
    _loadUserPreferences();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await _favoritesService.isFavorite(widget.product.id);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    setState(() => _isFavorite = !_isFavorite);
    await _favoritesService.toggleFavorite(widget.product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite
            ? "Added to Favorites ❤️"
            : "Removed from Favorites 💔"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedSize = prefs.getString('selectedSize-${widget.product.id}');
      int colorIndex = prefs.getInt('selectedColor-${widget.product.id}') ?? -1;
      if (colorIndex >= 0 && colorIndex < _colors.length) {
        _selectedColor = _colors[colorIndex];
      }
    });
  }

  Future<void> _saveUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'selectedSize-${widget.product.id}', _selectedSize ?? '');
    await prefs.setInt(
        'selectedColor-${widget.product.id}', _colors.indexOf(_selectedColor!));
    await prefs.setInt('selectedQuantity-${widget.product.id}', _quantity);
  }

  Widget _buildSizeOptions() {
    return Wrap(
      spacing: 8,
      children: _sizes.map((size) {
        final isSelected = _selectedSize == size;
        return ChoiceChip(
          label: Text(size),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedSize = size;
              _saveUserPreferences();
            });
          },
          selectedColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey[300],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildColorOptions() {
    return Wrap(
      spacing: 8,
      children: _colors.map((color) {
        final isSelected = _selectedColor == color;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedColor = color;
              _saveUserPreferences();
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.black : Colors.transparent,
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white)
                : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecommendedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "You may also like",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(5, (index) {
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage(widget.product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  backgroundColor: backgroundColor,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'product-${widget.product.id}',
                      child: Image.network(widget.product.imageUrl,
                          fit: BoxFit.cover),
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product.name,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textColor)),
                        const SizedBox(height: 8),
                        Text('\$${widget.product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textColor)),
                        const SizedBox(height: 16),
                        _buildSizeOptions(),
                        const SizedBox(height: 16),
                        _buildColorOptions(),
                        const SizedBox(height: 24),
                        _buildRecommendedProducts(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: backgroundColor, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5))
                ]),
                child: ElevatedButton(
                  onPressed: (_selectedSize != null && _selectedColor != null)
                      ? () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart')))
                      : null,
                  child: const Text("Add to Cart"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
