import 'package:flutter/material.dart';
import 'home_page.dart'; 
import 'search_products_screen.dart'; 
import 'scanner.dart'; 
// import 'saved.dart'; // Comment out the import for saved.dart

class DashboardScreen extends StatelessWidget {
  final String username;

  const DashboardScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Text(
              'Hello again!', 
              style: const TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold, 
                color: Color(0xFF333333), 
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'lib/images/logo.jpg', 
                    height: 250,
                    width: 330,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Caring for You, Preserving Our Planet.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400, 
                      color: Color(0xFF666666), 
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
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
                      // Do nothing for now
                      // You can later add functionality here
                      // For example, you might want to show a dialog or a message
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('Saved Products functionality coming soon!')),
                      // );
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
              color: Colors.black.withOpacity(0.05), 
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
              size: 48,
              color: const Color(0xFF333333), 
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
