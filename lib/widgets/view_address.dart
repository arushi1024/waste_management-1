import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_management/widgets/address_form.dart';
import 'package:waste_management/widgets/edit_address.dart';

class ViewAddressesScreen extends StatelessWidget {
  const ViewAddressesScreen({super.key});

  Future<List<Map<String, dynamic>>> _fetchUserAddresses() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    final userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

    final data = userDoc.data();
    if (data == null || data['address'] == null) return [];

    List<dynamic> addresses = data['address'];
    // Optionally sort by timestamp if available
    addresses.sort((a, b) {
      final at = a['timestamp'];
      final bt = b['timestamp'];
      if (at is Timestamp && bt is Timestamp) {
        return bt.compareTo(at); // descending
      }
      return 0;
    });

    return addresses.cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text('My Addresses'),
        backgroundColor: const Color(0xFF347C7D),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF347C7D),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddressFormScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Address"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchUserAddresses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No address found.\nTap "+" to add one!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final addresses = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final data = addresses[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.home,
                        color: Color(0xFF347C7D),
                        size: 30,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['value'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Ward: ${data['ward'] ?? ''}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF347C7D)),
                        tooltip: 'Edit Address',
                        onPressed: () {
                       final addressList = snapshot.data!;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => EditAddressScreen(
                                    addressIndex: index,
                                    addressList:
                                        addressList
                                            .map(
                                              (e) =>
                                                  Map<String, dynamic>.from(e),
                                            )
                                            .toList(),
                                  ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
