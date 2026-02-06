import 'package:flutter/material.dart';
import '../models/package_model.dart';
import '../services/data_service.dart';
import '../widgets/header_section.dart';
import '../widgets/left_column.dart';
import '../widgets/package_card.dart';
import '../widgets/footer.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/excitement_button.dart';
import '../widgets/login_avatar_button.dart';
import '../widgets/profile_sidebar.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';

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

  final List<String> _paymentMethods = ['UPI', 'Card', 'Wallet'];

  // Layout Constants - Adjust these to change the look!
  static const double gridSpacing = 4.0;
  static const double cardPadding = 4.0;
  static const double cardAspectRatio = 2.0;

  // Loaded packages
  List<Package> _packages = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final packages = await DataService.loadPackages();
      if (mounted) {
        setState(() {
          _packages = packages;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Failed to load packages.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Theme setup
    // Theme setup

    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      endDrawer: const ProfileSidebar(), // Add EndDrawer for Profile
      body: Theme(
        data: AppTheme.darkTheme,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    HeaderSection(
                      logo: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 80,
                          errorBuilder: (c, o, s) => const Icon(
                            Icons.videogame_asset,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: 'Zimutzy Official',
                      subtitle: 'Diamond Top-up Store',
                      titleStyle: AppTheme.titleLarge,
                      subtitleStyle: AppTheme.subtitle,
                    ),
                    const Positioned(
                      right: 150,
                      top: 20,
                      child: LoginAvatarButton(),
                    ),
                  ],
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1280),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _isLoading
                        ? const SizedBox(
                            height: 400,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : _errorMessage != null
                        ? SizedBox(
                            height: 400,
                            child: Center(child: Text(_errorMessage!)),
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 20),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  if (constraints.maxWidth > 1024) {
                                    // Desktop: 2-column layout
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: LeftColumn(),
                                        ),
                                        const SizedBox(width: 32),
                                        Expanded(
                                          flex: 3,
                                          child: _buildRightColumn(_packages),
                                        ),
                                      ],
                                    );
                                  } else {
                                    // Mobile/Tablet: 1-column layout
                                    return Column(
                                      children: [
                                        const LeftColumn(),
                                        const SizedBox(height: 32),
                                        _buildRightColumn(_packages),
                                      ],
                                    );
                                  }
                                },
                              ),
                              const Footer(),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRightColumn(List<Package> packages) {
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
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  final pkg = packages[index];
                  final isSelected = _selectedPackageId == pkg.id;
                  return PackageCard(
                    pkg: pkg,
                    isSelected: isSelected,
                    onTap: () => setState(() => _selectedPackageId = pkg.id),
                    cardPadding: cardPadding,
                  );
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
                  child: PaymentMethodCard(
                    method: method,
                    isSelected: isSelected,
                    onTap: () =>
                        setState(() => _selectedPaymentMethod = method),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 32),
        ExcitementButton(onPressed: () => _handleBuyNow(packages)),
      ],
    );
  }

  void _handleBuyNow(List<Package> packages) {
    if (_userIdController.text.isEmpty || _serverIdController.text.isEmpty) {
      _showSnack('Please enter your User ID and Server ID.');
      return;
    }
    if (_selectedPackageId == null) {
      _showSnack('Please select a package.');
      return;
    }

    // Check Login Status
    final authResult = Provider.of<AuthProvider>(context, listen: false);

    if (!authResult.isLoggedIn) {
      // Show Reminder to Login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login to save your purchase history!'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
    }

    // Success Logic
    final pkg = packages.firstWhere((p) => p.id == _selectedPackageId);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.cardBg,
        title: const Text(
          'Order Summary',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'User ID: ${_userIdController.text}\n'
          'Server ID: ${_serverIdController.text}\n'
          'Package: ${pkg.totalDiamonds} Diamonds\n' // Use total diamonds
          'Price: ₹${pkg.price}\n'
          'Payment: $_selectedPaymentMethod',
          style: const TextStyle(color: AppTheme.textGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);

              // Add to purchase history if logged in
              if (authResult.isLoggedIn) {
                authResult.addPurchase(pkg);
              }

              _showSnack('Order Successful!', isError: false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentIndigo,
            ),
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
        color: AppTheme.cardBg,
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
                  color: AppTheme.accentIndigo,
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
        fillColor: AppTheme.inputBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.accentIndigo, width: 2),
        ),
      ),
    );
  }
}
