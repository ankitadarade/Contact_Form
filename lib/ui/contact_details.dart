import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ContactDetailsPage extends StatelessWidget {
  final String contactName;
  const ContactDetailsPage({super.key, required this.contactName});
  Future<void> deleteContact() async {
    try {
      await FirebaseFirestore.instance
          .collection('Contacts')
          .where('name', isEqualTo: contactName)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });
      
    } catch (e) {
      SnackBar(content: Text('Error deleting document: $e'));
    }
  }

  @override
  Widget build(BuildContext context) {                        
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      body: StreamBuilder<QuerySnapshot>( 
        stream: FirebaseFirestore.instance
            .collection('Contacts')
            .where('name', isEqualTo: contactName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); 
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text(
                'Contact not found.'); 
          } else {
            final data =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;

            final name = data['name'];
            final phone = data['phone'];
            final email = data['email'];
            final address = data['address'];

            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      "$name",
                      style: const TextStyle(fontSize: 45, color: Colors.red),
                    ),
                  ),
                  const Divider(
                    color: Colors.amber,
                    thickness: 2.0, 
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text("Phone:  $phone"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(child: Text("Email:  $email")),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(child: Text("Address:  $address")),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deleteContact();                           //function which deletes the contact info
                      Navigator.pop(context);  
                    },
                    child: const Text('Delete Contact'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
