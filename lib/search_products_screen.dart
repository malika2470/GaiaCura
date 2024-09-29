import 'package:flutter/material.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  _SearchProductsScreenState createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  List<Product> products = [
    Product(
      assetName: 'pads.jpg',
      brand: 'Rael',
      productType: 'Pads',
      price: 6.99,
      description: 'Organic cotton pads',
      sustainabilityScore: 8,
    ),
    Product(
      assetName: 'tampons.jpg',
      brand: 'Cora',
      productType: 'Tampons',
      price: 10.00,
      description: 'Chlorine-free tampons',
      sustainabilityScore: 7,
    ),
    Product(
      assetName: 'period_underwear.jpg',
      brand: 'Thinx',
      productType: 'Period Underwear',
      price: 35.00,
      description: 'Leak-proof underwear',
      sustainabilityScore: 9,
    ),
  ];

  String currentSort = 'none';

  void sortProductsByPrice() {
    setState(() {
      if (currentSort == 'price_asc') {
        products.sort((a, b) => b.price.compareTo(a.price));
        currentSort = 'price_desc';
      } else {
        products.sort((a, b) => a.price.compareTo(b.price));
        currentSort = 'price_asc';
      }
    });
  }

  void sortProductsBySustainability() {
    setState(() {
      if (currentSort == 'sustainability_asc') {
        products.sort((a, b) => b.sustainabilityScore.compareTo(a.sustainabilityScore));
        currentSort = 'sustainability_desc';
      } else {
        products.sort((a, b) => a.sustainabilityScore.compareTo(b.sustainabilityScore));
        currentSort = 'sustainability_asc';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F0), // Same background color as the app
      appBar: AppBar(
        title: const Text(
          'Search Sustainable Products',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFD6D6D6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                hintText: 'Search products...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Filter Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price Filter Button
                FilterChip(
                  label: const Text('Price'),
                  selected: currentSort == 'price_asc' || currentSort == 'price_desc',
                  onSelected: (bool selected) {
                    sortProductsByPrice();
                  },
                  backgroundColor: Colors.white,
                  selectedColor: Colors.green[200],
                ),
                // Sustainability Filter Button
                FilterChip(
                  label: const Text('Most Sustainable'),
                  selected: currentSort == 'sustainability_asc' || currentSort == 'sustainability_desc',
                  onSelected: (bool selected) {
                    sortProductsBySustainability();
                  },
                  backgroundColor: Colors.white,
                  selectedColor: Colors.green[200],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Column(
                    children: [
                      ProductCard(
                        assetName: product.assetName,
                        brand: product.brand,
                        productType: product.productType,
                        price: '\$${product.price.toStringAsFixed(2)}',
                        description: product.description,
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String assetName;
  final String brand;
  final String productType;
  final double price;
  final String description;
  final int sustainabilityScore;

  Product({
    required this.assetName,
    required this.brand,
    required this.productType,
    required this.price,
    required this.description,
    required this.sustainabilityScore,
  });
}

class ProductCard extends StatelessWidget {
  final String assetName;
  final String brand;
  final String productType;
  final String price;
  final String description;

  const ProductCard({
    super.key,
    required this.assetName,
    required this.brand,
    required this.productType,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'lib/images/$assetName', // Construct the full path using the asset name
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productType,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Brand: $brand',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Price: $price',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
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
