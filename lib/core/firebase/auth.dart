import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/Home/view/homescreen.dart';
import 'package:login_signin/presentation/features/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //auth change user stream
  Future createUser(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  bool get isLoggedIn => _auth.currentUser != null;
  get authStateChanges => _auth.authStateChanges();
  get currentUser => _auth.currentUser;

  Future<Map<String, dynamic>?> getUser() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        print('User data: $userData');
        return userData;
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error getting user: $e');
    }
    return null;
  }

  Future<void> login(String email, String password, context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppRouter.push(context, Routes.home);
    } catch (e) {
      print(e);
    }
  }

  Future<void> importUsers(BuildContext context) async {
    final appData = Provider.of<AppDataProvider>(context, listen: false);
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance; // Make sure _auth is defined

    int successCount = 0;
    int errorCount = 0;
    List<Map<String, dynamic>> errors = [];

    for (final element in appData.users) {
      try {
        // Create user in Firebase Auth
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: element.email.trim(), // Added .trim() for safety
          password: element.password,
        );

        // Get the Firebase-generated UID
        final firebaseUid = userCredential.user!.uid;

        // Store additional data in Firestore
        await _firestore.collection('users').doc(firebaseUid).set({
          'customId': element.id,
          'firebaseUid': firebaseUid, // Store both IDs
          'email': element.email,
          'UserName': element.username,
        });

        successCount++;
        print('✅ Created user ${element.email} with custom ID: ${element.id}');
      } on FirebaseAuthException catch (e) {
        errorCount++;
        errors.add({
          'email': element.email,
          'customId': element.id,
          'error': 'Auth Error: ${e.code}',
          'message': e.message ?? 'No message',
        });
        print('❌ Auth error for ${element.email}: ${e.code} - ${e.message}');
      } on FirebaseException catch (e) {
        errorCount++;
        errors.add({
          'email': element.email,
          'customId': element.id,
          'error': 'Firestore Error: ${e.code}',
          'message': e.message ?? 'No message',
        });
        print(
          '❌ Firestore error for ${element.email}: ${e.code} - ${e.message}',
        );
      } catch (e) {
        errorCount++;
        errors.add({
          'email': element.email,
          'customId': element.id,
          'error': 'Unexpected Error',
          'message': e.toString(),
        });
        print('❌ Unexpected error for ${element.email}: $e');
      }
    }
  }

  Future<void> importCarts(BuildContext context) async {
    final appData = Provider.of<AppDataProvider>(context, listen: false);
    final _firestore = FirebaseFirestore.instance;

    int successCount = 0;
    int errorCount = 0;
    List<Map<String, dynamic>> errors = [];

    for (final element in appData.carts) {
      try {
        // Store additional data in Firestore
        await _firestore.collection('carts').doc(element.id.toString()).set({
          'id': element.id,
          'userId': element.userId, // Store both IDs
          'date': element.date,
        });
        for (final product in element.products) {
          await _firestore
              .collection('carts')
              .doc(element.id.toString())
              .collection('products')
              .doc(product.productId.toString())
              .set({
                'productId': product.productId,
                'quantity': product.quantity,
              });
        }
        successCount++;
        print('✅ Created cart');
      } on FirebaseAuthException catch (e) {
        print('❌ Auth error ');
      } on FirebaseException catch (e) {
        errorCount++;

        print('❌ Firestore error ');
      } catch (e) {
        errorCount++;

        print('❌ Unexpected error for : $e');
      }
    }
    // Print results in a readable format
    print('\n=== IMPORT RESULTS ===');
    print('Total users: ${appData.users.length}');
    print('Success: $successCount');
    print('Errors: $errorCount');

    if (errors.isNotEmpty) {
      print('\n=== ERROR DETAILS ===');
      for (final error in errors) {
        print('Email: ${error['email']}');
        print('Custom ID: ${error['customId']}');
        print('Error: ${error['error']}');
        print('Message: ${error['message']}');
        print('---');
      }
    } else {
      print('No errors occurred!');
    }
  }

  //sign In Anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
