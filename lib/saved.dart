import 'package:flutter/material.dart';
import 'search_products_screen.dart';

class Product {
  final String assetName;
  final String brand;
  final String productType;
  final double price;
  final String description;

  Product({
    required this.assetName,
    required this.brand,
    required this.productType,
    required this.price,
    required this.description,
  });
}

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
          : ListView.builder(
              itemCount: savedProducts.length,
              itemBuilder: (context, index) {
                final product = savedProducts.values.toList()[index];
                return Column(
                  children: [
                    ProductCard(
                      assetName: product.assetName,
                      brand: product.brand,
                      productType: product.productType,
                      price: '\$${product.price.toStringAsFixed(2)}',
                      description: product.description,
                      isSaved: true,
                      onSave: () {
                        // Implement saving logic if needed
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
    );
  }
}
