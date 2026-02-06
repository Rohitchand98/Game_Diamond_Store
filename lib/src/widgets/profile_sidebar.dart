import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/purchase_model.dart';
import '../constants/app_theme.dart';
import 'package:intl/intl.dart';

class ProfileSidebar extends StatelessWidget {
  const ProfileSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch Auth Provider
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    if (user == null) {
      return const SizedBox(); // Should not happen if logic is correct
    }

    return Container(
      width: 300,
      color: AppTheme.bgDark,
      child: Column(
        children: [
          // Header / Profile Info
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            color: AppTheme.cardBg,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      : null,
                  backgroundColor: AppTheme.accentIndigo,
                  child: user.photoURL == null
                      ? const Icon(Icons.person, size: 40, color: Colors.white)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  user.displayName ?? 'User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.email ?? '',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // Close drawer
                    authProvider.signOut();
                  },
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text('Sign Out'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Colors.white10),

          // Purchase History Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                Icon(Icons.history, color: AppTheme.accentYellow, size: 20),
                SizedBox(width: 8),
                Text(
                  'Purchase History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: authProvider.purchaseHistory.isEmpty
                ? Center(
                    child: Text(
                      'No purchases yet.',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  )
                : ListView.builder(
                    itemCount: authProvider.purchaseHistory.length,
                    itemBuilder: (context, index) {
                      final purchase = authProvider.purchaseHistory[index];
                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            purchase.status == PurchaseStatus.complete
                                ? Icons.check_circle
                                : Icons.hourglass_top,
                            color: purchase.status == PurchaseStatus.complete
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                        title: Text(
                          purchase.package.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          DateFormat(
                            'MMM d, y h:mm a',
                          ).format(purchase.timestamp),
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                        trailing: Text(
                          '₹${purchase.package.price}',
                          style: const TextStyle(
                            color: AppTheme.accentYellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
