import 'package:flutter/material.dart';
import 'home_page.dart'; // Import HomePage for the chatbot option
import 'search_products_screen.dart'; // Import SearchProductsScreen
import 'scanner.dart'; // Import the Scanner screen

class DashboardScreen extends StatelessWidget {
  final String username;

  const DashboardScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F0), // Same background color as the Auth screen
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Add some padding to move it higher
            Text(
              'Hello again, $username!', // Personalized welcome message
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'lib/images/logo.jpg', // Replace with your logo file path
                    height: 250,
                    width: 330,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Caring for You, Preserving Our Planet.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Number of cards per row
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  DashboardCard(
                    title: 'Chatbot',
                    icon: Icons.chat_bubble_outline,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                  ),
                  DashboardCard(
                    title: 'Scan',
                    icon: Icons.camera_alt_outlined,
                    onTap: () {
                      // Navigate to Scanner screen
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Scanner()),
                      );
                    },
                  ),
                  DashboardCard(
                    title: 'Search Products',
                    icon: Icons.search,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SearchProductsScreen()),
                      );
                    },
                  ),
                  DashboardCard(
                    title: 'Saved Products',
                    icon: Icons.bookmark_outline,
                    onTap: () {
                      // Implement View saved sustainable products functionality here
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

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
