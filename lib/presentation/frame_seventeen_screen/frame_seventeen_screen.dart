import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FrameSeventeenScreen extends StatefulWidget {
  const FrameSeventeenScreen({Key? key}) : super(key: key);

  @override
  State<FrameSeventeenScreen> createState() => _FrameSeventeenScreenState();
}

class _FrameSeventeenScreenState extends State<FrameSeventeenScreen> {
  String userName = '';
  String userEmail = '';
  String userType = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserDataFromFirebase();
  }

  Future<void> fetchUserDataFromFirebase() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        final uid = currentUser.uid;

        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          setState(() {
            userName = data?['name'] ?? '';
            userEmail = data?['email'] ?? '';
            userType = data?['userType'] ?? '';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green.shade700, size: 26),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.green.shade100,
                      child: Icon(Icons.person, size: 60, color: Colors.green.shade700),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.shade100),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        children: [
                          buildInfoRow(
                              icon: Icons.person, label: "Full Name", value: userName),
                          Divider(color: Colors.green.shade100),
                          buildInfoRow(
                              icon: Icons.email, label: "Email Address", value: userEmail),
                          Divider(color: Colors.green.shade100),
                          buildInfoRow(
                              icon: Icons.account_box, label: "User Type", value: userType),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        letterSpacing: 1.1,
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
