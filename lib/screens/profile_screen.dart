import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontFamily: 'Times New Roman', fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        child: const Text(
                          'MF',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'M. Fahad',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'mf6309559@gmail.com',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '+923221425612',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileItem(icon: Icons.shopping_bag, title: 'My Orders'),
            Divider(height: 1, color: Colors.grey[200]),
            _buildProfileItem(
              icon: Icons.location_on,
              title: 'Shipping Address',
            ),
            Divider(height: 1, color: Colors.grey[200]),
            _buildProfileItem(icon: Icons.payment, title: 'Payment Methods'),
            Divider(height: 1, color: Colors.grey[200]),
            _buildProfileItem(icon: Icons.settings, title: 'Settings'),
            Divider(height: 1, color: Colors.grey[200]),
            _buildProfileItem(icon: Icons.help, title: 'Help & Support'),
            Divider(height: 1, color: Colors.grey[200]),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black,
      ),
      onTap: () {
        // Handle item tap
      },
    );
  }
}
