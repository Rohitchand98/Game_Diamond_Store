import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiamondStoreScreen extends StatefulWidget {
  const DiamondStoreScreen({super.key});

  @override
  State<DiamondStoreScreen> createState() => _DiamondStoreScreenState();
}

class _DiamondStoreScreenState extends State<DiamondStoreScreen> {
  // State
  int? _selectedPackageId;
  String _selectedPaymentMethod = 'UPI'; // Default
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _serverIdController = TextEditingController();

  // Data Models
  final List<Map<String, dynamic>> _packages = [
    {'id': 1, 'diamonds': 55, 'bonus': 5, 'price': 75},
    {'id': 2, 'diamonds': 86, 'bonus': 8, 'price': 110},
    {'id': 3, 'diamonds': 165, 'bonus': 15, 'price': 215},
    {'id': 4, 'diamonds': 172, 'bonus': 16, 'price': 220},
    {'id': 5, 'diamonds': 257, 'bonus': 23, 'price': 320},
    {
      'id': 6,
      'diamonds': 275,
      'bonus': 25,
      'price': 335,
      'special': 'Recharge Task Pack',
    },
    {'id': 7, 'diamonds': 312, 'bonus': 28, 'price': 390},
    {'id': 8, 'diamonds': 343, 'bonus': 31, 'price': 430},
    {'id': 9, 'diamonds': 514, 'bonus': 65, 'price': 640},
    {'id': 10, 'diamonds': 1000, 'bonus': 165, 'price': 920},
    {'id': 11, 'diamonds': 1500, 'bonus': 250, 'price': 1234},
  ];

  final List<String> _paymentMethods = ['UPI', 'Card', 'Wallet'];

  // Layout Constants - Adjust these to change the look!
  static const double gridSpacing = 4.0; // Reduced gap
  static const double cardPadding = 4.0; // Reduced padding
  static const double cardAspectRatio =
      2.5; // Made cards much shorter to reduce vertical gap perception

  // Colors
  static const Color bgDark = Color(0xFF111827); // Gray 900
  static const Color cardBg = Color(0xFF1f2937); // Gray 800
  static const Color accentYellow = Color(0xFFfacc15); // Yellow 400
  static const Color accentIndigo = Color(0xFF4f46e5); // Indigo 600
  static const Color textGray = Color(0xFF9ca3af); // Gray 400

  @override
  Widget build(BuildContext context) {
    // Theme setup
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      backgroundColor: bgDark,
      body: Theme(
        data: ThemeData.dark().copyWith(
          textTheme: textTheme,
          scaffoldBackgroundColor: bgDark,
          colorScheme: const ColorScheme.dark(
            primary: accentIndigo,
            secondary: accentYellow,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 40),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 1024) {
                        // Desktop: 2-column layout
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 2, child: _buildLeftColumn()),
                            const SizedBox(width: 32),
                            Expanded(flex: 3, child: _buildRightColumn()),
                          ],
                        );
                      } else {
                        // Mobile/Tablet: 1-column layout
                        return Column(
                          children: [
                            _buildLeftColumn(),
                            const SizedBox(height: 32),
                            _buildRightColumn(),
                          ],
                        );
                      }
                    },
                  ),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Placeholder for Logo
        Image.network(
          'https://placehold.co/100x100/1f2937/ffffff?text=MLBB',
          height: 80,
          errorBuilder: (ctx, _, __) =>
              const Icon(Icons.diamond, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Text(
          'Mobile Legends: Bang Bang',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Official Diamond Top-up Store',
          style: GoogleFonts.inter(fontSize: 18, color: textGray),
        ),
      ],
    );
  }

  Widget _buildLeftColumn() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111827), // Inner dark bg
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/hero_bg.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              _buildBadge(
                '✓ 24/7 Support',
                Colors.green.shade300,
                Colors.green.withOpacity(0.2),
              ),
              _buildBadge(
                '✓ Secure Payment',
                Colors.blue.shade300,
                Colors.blue.withOpacity(0.2),
              ),
              _buildBadge(
                '✓ Fast Delivery',
                Colors.yellow.shade300,
                Colors.yellow.withOpacity(0.2),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Mobile Legends: Bang Bang',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Join your friends in a brand new 5v5 MOBA showdown against real human opponents, Mobile Legends: Bang Bang! Choose your favorite heroes and build the perfect team with your comrades-in-arms!',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: textGray,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          const Divider(color: Color(0xFF374151)),
          const SizedBox(height: 24),
          Text(
            'How to Recharge?',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          _buildInstructionStep(1, 'Enter your User ID and Server ID.'),
          _buildInstructionStep(2, 'Choose the package you want to buy.'),
          _buildInstructionStep(3, 'Select your preferred payment method.'),
          _buildInstructionStep(4, 'Click "Buy Now" and complete the payment.'),
          _buildInstructionStep(5, 'Diamonds will be credited shortly.'),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color textColor, Color bgColor) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: bgColor,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide.none,
    );
  }

  Widget _buildInstructionStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: const TextStyle(
              color: textGray,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(text, style: const TextStyle(color: textGray)),
          ),
        ],
      ),
    );
  }

  Widget _buildRightColumn() {
    return Column(
      children: [
        _buildSection(
          number: 1,
          title: 'Enter Your Account Details',
          content: Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _userIdController,
                  hint: 'User ID',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _serverIdController,
                  hint: 'Server ID',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSection(
          number: 2,
          title: 'Select Package',
          content: LayoutBuilder(
            builder: (ctx, constraints) {
              // Responsive grid count
              int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: gridSpacing,
                  mainAxisSpacing: gridSpacing,
                  childAspectRatio: cardAspectRatio,
                ),
                itemCount: _packages.length,
                itemBuilder: (context, index) {
                  final pkg = _packages[index];
                  final isSelected = _selectedPackageId == pkg['id'];
                  return _buildPackageCard(pkg, isSelected);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        _buildSection(
          number: 3,
          title: 'Select Payment Method',
          content: Row(
            children: _paymentMethods.map((method) {
              final isSelected = _selectedPaymentMethod == method;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: InkWell(
                    onTap: () =>
                        setState(() => _selectedPaymentMethod = method),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? accentIndigo : cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? accentIndigo
                              : const Color(0xFF374151),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        method,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: _handleBuyNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentYellow,
              foregroundColor: Colors.black, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
            child: const Text(
              'Buy Now',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  void _handleBuyNow() {
    if (_userIdController.text.isEmpty || _serverIdController.text.isEmpty) {
      _showSnack('Please enter your User ID and Server ID.');
      return;
    }
    if (_selectedPackageId == null) {
      _showSnack('Please select a package.');
      return;
    }

    // Success Logic mockup
    final pkg = _packages.firstWhere((p) => p['id'] == _selectedPackageId);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: cardBg,
        title: const Text(
          'Order Summary',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'User ID: ${_userIdController.text}\n'
          'Server ID: ${_serverIdController.text}\n'
          'Package: ${pkg['diamonds']} Diamonds\n'
          'Price: ₹${pkg['price']}\n'
          'Payment: $_selectedPaymentMethod',
          style: const TextStyle(color: textGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showSnack('Order Successful!', isError: false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: accentIndigo),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSnack(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Widget _buildSection({
    required int number,
    required String title,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: accentIndigo,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          content,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: const Color(0xFF374151), // Gray 700
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentIndigo, width: 2),
        ),
      ),
    );
  }

  Widget _buildPackageCard(Map<String, dynamic> pkg, bool isSelected) {
    return InkWell(
      onTap: () => setState(() => _selectedPackageId = pkg['id']),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? accentYellow : const Color(0xFF374151),
            width: isSelected ? 2 : 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accentYellow.withOpacity(0.4),
                    blurRadius: 12,
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${pkg['diamonds']}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (pkg['bonus'] != null)
              Text(
                '+${pkg['bonus']} 💎',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            // Removed Spacer() to reduce gap
            const SizedBox(height: 4),
            if (pkg['special'] != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  pkg['special'],
                  style: const TextStyle(fontSize: 10, color: accentYellow),
                  textAlign: TextAlign.center,
                ),
              ),
            Text(
              '₹${pkg['price']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Text(
        '© 2024 Mobile Legends Diamond Store. All rights reserved.',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
    );
  }
}
