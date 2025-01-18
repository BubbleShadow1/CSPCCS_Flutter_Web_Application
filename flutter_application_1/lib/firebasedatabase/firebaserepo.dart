// FirebaseRepository
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add User to Database
  Future<void> addUser(String username) async {
    try {
      await _firestore.collection('users').add({
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
        'loggedin': 'yes',
        'firstTimeLogin': true, // Add a flag for first-time login
      });
    } catch (e) {
      throw Exception("Failed to add user to database: $e");
    }
  }

  // Check if user exists and if it is the first time
  Future<bool> isFirstTimeLogin(String username) async {

      final snapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username).orderBy('createdAt', descending: false).get();
          
        

      if (snapshot.docs.isEmpty) {
        return true; // First-time login if no user is found
      }

      final user = snapshot.docs.first;
      return user['firstTimeLogin']==null ? true : false; // Return if it's their first time


    //  catch (e) {
    //   throw Exception("Error checking first-time login: $e");
    // }
  }

  // Add Data to Database
  Future<void> addData(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').add(data);
    } catch (e) {
      throw Exception("Failed to add data to database: $e");
    }
  }

  // Fetch Users from Database
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').orderBy('createdAt', descending: false).get();


      return snapshot.docs.map((doc) {
        return {"id": doc.id, ...doc.data() as Map<String, dynamic>};
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch users: $e");
    }
  }
}
