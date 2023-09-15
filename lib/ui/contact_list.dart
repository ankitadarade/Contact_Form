import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact__form/ui/contact_details.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(                            
      stream: FirebaseFirestore.instance
          .collection('Contacts')
          .orderBy('name')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No contacts found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final contact = snapshot.data!.docs[index];
            final name = contact['name'];
            final phone = contact['phone'];
            final mob = phone.toString();
            return Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: const Color.fromARGB(255, 132, 131, 131)),
                    color: const Color.fromARGB(255, 215, 212, 212)),
                child: ListTile(
                  title: Text(name),
                  trailing: Text(mob),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ContactDetailsPage(contactName: name),
                    ));
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
