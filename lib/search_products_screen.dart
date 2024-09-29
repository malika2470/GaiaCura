import 'package:flutter/material.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  _SearchProductsScreenState createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  // List of products
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
    Product(
      assetName: 'pads2.jpg',
      brand: 'Viv',
      productType: 'Pads',
      price: 12.00,
      description: 'Bamboo Pads',
      sustainabilityScore: 9,
    ),
    Product(
      assetName: 'temp2.jpg',
      brand: 'Viv',
      productType: 'Pads',
      price: 12.00,
      description: 'Bamboo Pads',
      sustainabilityScore: 9,
    ),
  ];

  // Saved products dictionary
  Map<String, Product> savedProducts = {};  

  // Other states
  String currentSort = 'none';
  List<Product> _filteredProducts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredProducts = products;
    _searchController.addListener(_filterProducts);
  }

  // Function to filter products
  void _filterProducts() {
    setState(() {
      _filteredProducts = products
          .where((product) =>
              product.productType.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Sustainable Products', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFD6D6D6),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedProductsScreen(savedProducts: savedProducts),
                ),
              );
            },
          ),
        ],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return Column(
                  children: [
                    ProductCard(
                      assetName: product.assetName,
                      brand: product.brand,
                      productType: product.productType,
                      price: '\$${product.price.toStringAsFixed(2)}',
                      description: product.description,
                      isSaved: savedProducts.containsKey(product.assetName),
                      onSave: () {
                        setState(() {
                          if (savedProducts.containsKey(product.assetName)) {
                            savedProducts.remove(product.assetName);
                          } else {
                            savedProducts[product.assetName] = product;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Dummy Product class for demo purposes
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

// Dummy ProductCard class for demo purposes
class ProductCard extends StatelessWidget {
  final String assetName;
  final String brand;
  final String productType;
  final String price;
  final String description;
  final bool isSaved;
  final VoidCallback onSave;

  const ProductCard({
    super.key,
    required this.assetName,
    required this.brand,
    required this.productType,
    required this.price,
    required this.description,
    required this.isSaved,
    required this.onSave,
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
                'lib/images/$assetName',
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
            IconButton(
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: isSaved ? Colors.green : Colors.grey,
              ),
              onPressed: onSave,
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy SavedProductsScreen class for demo purposes
class SavedProductsScreen extends StatelessWidget {
  final Map<String, Product> savedProducts;

  const SavedProductsScreen({super.key, required this.savedProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Products'),
        backgroundColor: const Color(0xFFD6D6D6),
      ),
      body: savedProducts.isEmpty
          ? const Center(
              child: Text('No saved products'),
            )
          : ListView(
              children: savedProducts.values.map((product) {
                return ProductCard(
                  assetName: product.assetName,
                  brand: product.brand,
                  productType: product.productType,
                  price: '\$${product.price.toStringAsFixed(2)}',
                  description: product.description,
                  isSaved: true,  // All products are saved here
                  onSave: () {},  // Do nothing since it's a saved page
                );
              }).toList(),
            ),
    );
  }
}
