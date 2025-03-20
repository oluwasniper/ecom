import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/presentation/screens/product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.phone_android, 'label': "Phones", 'color': Colors.blue},
    {'icon': Icons.laptop, 'label': "Laptops", 'color': Colors.green},
    {'icon': Icons.tv, 'label': "TVs", 'color': Colors.orange},
    {'icon': Icons.watch, 'label': "Watches", 'color': Colors.purple},
    {'icon': Icons.headphones, 'label': "Audio", 'color': Colors.red},
    {'icon': Icons.camera_alt, 'label': "Cameras", 'color': Colors.teal},
    {'icon': Icons.sports_esports, 'label': "Gaming", 'color': Colors.indigo},
    {'icon': Icons.home, 'label': "Smart Home", 'color': Colors.brown},
  ];

  final List<Product> _featuredProducts = [
    Product(
      id: '1',
      name: 'Wireless Earbuds Pro',
      description:
          'High-quality wireless earbuds with active noise cancellation',
      price: 129.99,
      category: 'Audio',
      imageUrl: 'assets/images/product0.jpg',
    ),
    Product(
      id: '2',
      name: 'Smart Watch Series X',
      description: 'Advanced fitness tracker with heart rate monitoring',
      price: 199.99,
      category: 'Watches',
      imageUrl: 'assets/images/product1.jpg',
    ),
    Product(
      id: '3',
      name: 'Premium Laptop Stand',
      description: 'Ergonomic aluminum laptop stand with cooling',
      price: 49.99,
      category: 'Laptops',
      imageUrl: 'assets/images/product2.jpg',
    ),
    Product(
      id: '4',
      name: 'HD Webcam',
      description: '1080p webcam with built-in microphone',
      price: 39.99,
      category: 'Cameras',
      imageUrl: 'assets/images/product3.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildBanner(),
                  _buildCategories(),
                  _buildFeaturedProducts(),
                  const SizedBox(height: 100), // Space for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      title: Text(
        'E-Commerce',
        style: GoogleFonts.lato(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            // Navigate to cart
          },
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            bottom: -30,
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 200,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summer Sale',
                  style: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Up to 50% off',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Categories"),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Handle category tap
        },
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _categories[index]['icon'],
              size: 32,
              color: _categories[index]['color'],
            ),
            const SizedBox(height: 5),
            Text(
              _categories[index]['label'],
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Featured Products"),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: _featuredProducts.length,
            itemBuilder: (context, index) {
              return _buildProductCard(_featuredProducts[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(product.imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.name, style: GoogleFonts.lato(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(onPressed: () {}, child: const Text("See All")),
      ],
    );
  }
}
