import '../models/package_model.dart';

enum PurchaseStatus { pending, complete }

class Purchase {
  final String id;
  final String userId;
  final Package package;
  final PurchaseStatus status;
  final DateTime timestamp;

  Purchase({
    required this.id,
    required this.userId,
    required this.package,
    required this.status,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'packageId': package.id,
      'status': status.name,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
