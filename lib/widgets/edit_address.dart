import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  final int addressIndex;
  final List<Map<String, dynamic>> addressList;

  const EditAddressScreen({
    super.key,
    required this.addressIndex,
    required this.addressList,
  });

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
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
  void initState() {
    super.initState();
    final current = widget.addressList[widget.addressIndex];
    addressController.text = current['value'] ?? '';
    selectedWard = current['ward'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF347C7D),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Edit Address',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.lime[200],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  label('Address:'),
                  TextFormField(
                    controller: addressController,
                    maxLines: 4,
                    decoration: fieldDecoration('Enter your full address'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter address' : null,
                  ),
                  const SizedBox(height: 20),

                  label('Ward:'),
                  DropdownButtonFormField<String>(
                    value: selectedWard,
                    decoration: fieldDecoration('Select your ward'),
                    items: wards.map((ward) {
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
                    validator: (value) =>
                        value == null ? 'Please select a ward' : null,
                  ),
                  const SizedBox(height: 30),

                Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final user = FirebaseAuth.instance.currentUser;
            if (user == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User not logged in')),
              );
              return;
            }
      
            widget.addressList[widget.addressIndex] = {
              'value': addressController.text.trim(),
              'ward': selectedWard,
            };
      
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update({'address': widget.addressList});
      
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Address updated!')),
            );
      
            Navigator.pop(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lime[400],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'CONFIRM',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    ),
    const SizedBox(height: 16),
   SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () async {
      final confirm = await _showDeleteConfirmationDialog();
      if (confirm == true) {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not logged in')),
          );
          return;
        }

        widget.addressList.removeAt(widget.addressIndex);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'address': widget.addressList});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address deleted!')),
        );

        Navigator.pop(context);
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red[400],
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: const Text(
      'DELETE',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),
),

  ],
),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  InputDecoration fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
  Future<bool?> _showDeleteConfirmationDialog() {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Delete',style: TextStyle(color: Colors.black)),
        content: const Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCEL',style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('YES',style: TextStyle(color: Colors.black),),
          ),
        ],
      );
    },
  );
}

}



