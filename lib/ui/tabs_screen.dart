import 'package:contact__form/ui/contact_list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import './contact_form.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> pages;

  // ignore: non_constant_identifier_names
  int _Selectedpageindex = 0;           

  void _selectPage(int index) {
    setState(() {
      _Selectedpageindex = index;
    });
  }

  @override
  void initState() {
    pages = [
      {'page': const ContactList(), 'title': 'Contacts'},
      {'page': const ContactFormPage(), 'title': 'Contact Form'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pages[_Selectedpageindex]['title'] as String),
        ),
        body: pages[_Selectedpageindex]['page'] as Widget,
        bottomNavigationBar: CurvedNavigationBar(
          items: const [
            Icon(Icons.list_sharp),
            Icon(Icons.contact_page),
          ],
          backgroundColor: Colors.amber,
          buttonBackgroundColor: Colors.amber.shade800,
          onTap: _selectPage,
        ));
  }
}
