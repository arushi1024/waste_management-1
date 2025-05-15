import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key});

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? selectedWard;

  final List<String> wards = [
    'West',
    'Bommanahalli',
    'Mahadevapura',
    'South',
    'RR Nagar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF347C7D), // Teal background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: Text(
                      'Change Address',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.lime[200], // Light green title
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Address Label & Field
                  label('Address:'),
                  TextFormField(
                    controller: addressController,
                    maxLines: 4,
                    decoration: fieldDecoration('Enter your full address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Ward Label & Dropdown
                  label('Ward:'),
                  DropdownButtonFormField<String>(
                    value: selectedWard,
                    decoration: fieldDecoration('Select your ward'),
                    items:
                        wards.map((ward) {
                          return DropdownMenuItem(
                            value: ward,
                            child: Text(ward),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedWard = value;
                      });
                    },
                    validator:
                        (value) =>
                            value == null ? 'Please select a ward' : null,
                  ),

                  const SizedBox(height: 30),

                  // Confirm Button
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final userDoc = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid);

                              final newAddressEntry = {
                                'value': addressController.text.trim(),
                                'ward': selectedWard,
                                'block':
                                    selectedWard, // Assuming the block is the same as the ward for now
                                'email': user.email,
                                'name': user.displayName ?? '',
                                'userType': 'Customer',
                                // 'timestamp': FieldValue.serverTimestamp(),
                              };

                              try {
                                // Get the current list of addresses
                                final userSnapshot = await userDoc.get();
                                final existingAddresses = List.from(
                                  userSnapshot.data()?['address'] ?? [],
                                );

                                // Add the new address to the existing list
                                existingAddresses.add(newAddressEntry);

                                // Update the address field with the new list
                                await userDoc.update({
                                  'address': existingAddresses,
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Address added successfully!',
                                    ),
                                  ),
                                );

                                // Clear the form fields
                                addressController.clear();
                                setState(() {
                                  selectedWard = null;
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to update address'),
                                  ),
                                );
                                print("error = $e");
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('User not logged in'),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lime[400], // Lime button
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'CONFIRM',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper to build label text
  Widget label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.lime[200],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Helper to build input fields
  Widget inputField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      decoration: fieldDecoration(hint),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
    );
  }

  // Decoration for fields
  InputDecoration fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
