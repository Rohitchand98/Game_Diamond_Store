import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy Data for Diamond Packages
  final List<Map<String, dynamic>> _packages = [
    {'diamonds': 55, 'bonus': 5, 'price': 75},
    {'diamonds': 86, 'bonus': 8, 'price': 110},
    {'diamonds': 165, 'bonus': 15, 'price': 215},
    {'diamonds': 172, 'bonus': 16, 'price': 220},
    {'diamonds': 257, 'bonus': 23, 'price': 320},
    {'diamonds': 275, 'bonus': 25, 'price': 335},
    {'diamonds': 312, 'bonus': 28, 'price': 390},
    {'diamonds': 343, 'bonus': 31, 'price': 430},
    {'diamonds': 514, 'bonus': 65, 'price': 640},
  ];

  int _selectedPackageIndex = -1;
  String _selectedPaymentMethod = 'UPI';

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _serverIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Hero Section
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/hero_bg.jpg', fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                      ),
                    ),
                  ),
                  // Logo Overlay
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset('assets/images/logo.png', height: 80),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content Container
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 0,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 2. User Account Details
                    _buildSectionHeader('1', 'Enter Your Account Details'),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _userIdController,
                            decoration: const InputDecoration(
                              hintText: 'User ID',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: _serverIdController,
                            decoration: const InputDecoration(
                              hintText: 'Server ID',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // 3. Select Package
                    _buildSectionHeader('2', 'Select Package'),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                3, // Responsive via LayoutBuilder ideally
                            childAspectRatio: 1.6,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: _packages.length,
                      itemBuilder: (context, index) {
                        final pkg = _packages[index];
                        final isSelected = _selectedPackageIndex == index;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedPackageIndex = index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF1F263A)
                                  : const Color(0xFF151A2D),
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${pkg['diamonds']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    if (pkg['bonus'] > 0)
                                      Text(
                                        ' +${pkg['bonus']}',
                                        style: const TextStyle(
                                          color: Color(0xFF00C8F0),
                                          fontSize: 14,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹${pkg['price']}',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    // 4. Payment Method
                    _buildSectionHeader('3', 'Select Payment Method'),
                    Row(
                      children: ['UPI', 'Card', 'Wallet'].map((method) {
                        final isSelected = _selectedPaymentMethod == method;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: GestureDetector(
                              onTap: () => setState(
                                () => _selectedPaymentMethod = method,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(
                                          0xFF5A67D8,
                                        ) // Purple/Blue highlight
                                      : const Color(0xFF1F263A),
                                  borderRadius: BorderRadius.circular(8),
                                  border: isSelected
                                      ? Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        )
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    method,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),

                    // 5. Buy Now Button
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement Buy Logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Order...')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Footer
                    Center(
                      child: Text(
                        '© 2026 Mobile Legends Diamond Store. All rights reserved.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String number, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF5A67D8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
