import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/purchase_model.dart';
import '../models/package_model.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth? _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  User? _currentUser;

  // Mock User for when Firebase is missing
  MockUser? _mockUser;

  final List<Purchase> _purchaseHistory = [];

  // Return Mock user if real user is null but we are in mock mode
  dynamic get currentUser => _currentUser ?? _mockUser;

  List<Purchase> get purchaseHistory => _purchaseHistory;
  bool get isLoggedIn => _currentUser != null || _mockUser != null;

  AuthProvider() {
    _initGoogleSignIn();
    _initializeAuth();
  }

  static bool _isGoogleSignInInitialized = false;
  Future<void> _initGoogleSignIn() async {
    if (_isGoogleSignInInitialized) return;
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      debugPrint("GoogleSignIn init error: $e");
    }
  }

  void _initializeAuth() {
    try {
      _auth = FirebaseAuth.instance;
      // Listen to Auth State Changes
      _auth?.authStateChanges().listen((User? user) {
        _currentUser = user;
        notifyListeners();
      });
    } catch (e) {
      debugPrint("FirebaseAuth not available (Mock Mode): $e");
    }
  }

  // Sign In with Google
  Future<void> signInWithGoogle() async {
    try {
      if (_auth == null) {
        throw "FirebaseAuth not initialized";
      }

      await _initGoogleSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: null,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth!.signInWithCredential(
        credential,
      );

      _currentUser = userCredential.user;
      _mockUser = null;
      notifyListeners();
    } catch (e) {
      debugPrint("Real Auth failed: $e. Switching to Mock Auth.");
      _enableMockLogin();
    }
  }

  void _enableMockLogin() {
    _mockUser = MockUser(
      displayName: "Demo User",
      email: "demo@example.com",
      photoURL: null,
      uid: "mock-uid-123",
    );
    notifyListeners();
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth?.signOut();
    } catch (e) {
      // Ignore errors during mock sign out
    }
    _currentUser = null;
    _mockUser = null;
    _purchaseHistory.clear(); // Clear history on logout
    notifyListeners();
  }

  // Add Purchase (Simulated)
  void addPurchase(Package pkg) {
    if (!isLoggedIn) return;

    final userId = _currentUser?.uid ?? _mockUser?.uid ?? 'unknown';

    final newPurchase = Purchase(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      package: pkg,
      status: PurchaseStatus.pending, // Initially pending
      timestamp: DateTime.now(),
    );

    _purchaseHistory.insert(0, newPurchase); // Add to top
    notifyListeners();

    // Simulate completion after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      final index = _purchaseHistory.indexWhere((p) => p.id == newPurchase.id);
      if (index != -1) {
        _purchaseHistory[index] = Purchase(
          id: newPurchase.id,
          userId: newPurchase.userId,
          package: newPurchase.package,
          status: PurchaseStatus.complete,
          timestamp: newPurchase.timestamp,
        );
        notifyListeners();
      }
    });
  }
}

// Simple Mock User class to mimic Firebase User
class MockUser {
  final String displayName;
  final String email;
  final String? photoURL;
  final String uid;

  MockUser({
    required this.displayName,
    required this.email,
    this.photoURL,
    required this.uid,
  });
}
