import 'dart:io';

import 'package:flutter/material.dart';
import 'contact_db.dart';
import 'add_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _filteredContacts = [];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 1) { // Exit button index (assuming 0 is for Home)
        // Add your exit logic here (e.g., Navigator.pop(context) to go back)
        Navigator.pop(exit(0)); // Example: Pop this screen to go back
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final contacts = await ContactDB().getContacts();
    setState(() {
      _contacts = contacts;
      _filteredContacts = contacts;
    });
  }

  void _addContact() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddContactScreen()),
    ).then((_) => _loadContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addContact,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _filteredContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredContacts[index]['name']),
                  subtitle: Text(_filteredContacts[index]['phone']),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Exit',
          ),
        ],
      ),
    );
  }
}
