import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ViewComplaintsScreen extends StatelessWidget {
  const ViewComplaintsScreen({super.key});

  Future<List<Map<String, dynamic>>> fetchUserComplaints() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    // Ensure that you're querying the correct collection name 'complaints'
    final snapshot =
        await FirebaseFirestore.instance
            .collection('complaints')
            .where(
              'userId',
              isEqualTo: uid,
            ) // Use userId to filter complaints for the current user
            .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Complaints")),
      body: FutureBuilder(
        future: fetchUserComplaints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading complaints"));
          }

          final complaints = snapshot.data as List<Map<String, dynamic>>;

          if (complaints.isEmpty) {
            return Center(child: Text("No complaints found."));
          }

      return  ListView.builder(
  itemCount: complaints.length,
  itemBuilder: (context, index) {
    final complaint = complaints[index];
    
    // Define the status color based on the value of 'status'
    Color statusColor = Colors.grey; // Default color
    if (complaint['status'] == 'closed') {
      statusColor = Colors.green; // Green for resolved
    } else if (complaint['status'] == 'Pending') {
      statusColor = Colors.orange; // Orange for pending
    } else if (complaint['status'] == 'open') {
      statusColor = Colors.red; // Red for rejected
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.add_alert)),
        title: Text(complaint['vehicleNumber'] ?? 'No Vehicle Number'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(complaint['reason'] ?? 'No Reason'),
            SizedBox(height: 4),
            Text(
              'Status: ${complaint['status'] ?? 'No Status'}',
              style: TextStyle(
                fontSize: 12,
                color: statusColor, // Apply dynamic color
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Text(
          complaint['timestamp'] != null
              ? DateFormat('yyyy-MM-dd – hh:mm a').format((complaint['timestamp'] as Timestamp).toDate())
              : 'No Timestamp',
          style: TextStyle(fontSize: 12),
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
