import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student1408049/Database/DBHelper.dart';
import 'package:student1408049/models/Contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      home: ContactList(),
    );
  }
}

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late Future<List<Contact>> _contactList;

  @override
  void initState() {
    super.initState();
    _contactList = DBHelper().getContacts();
  }

  void _refreshContacts() {
    setState(() {
      _contactList = DBHelper().getContacts();
    });
  }

  void _showAddDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Enter name...'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Enter phone...'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Create'),
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty &&
                    nameController.text.length >= 5 &&
                    nameController.text.length <= 60) {
                  Contact newContact = Contact(
                    name: nameController.text,
                    phone: phoneController.text,
                  );
                  await DBHelper().insertContact(newContact);
                  Navigator.of(context).pop();
                  _refreshContacts();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(Contact contact) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text('Are you sure you want to delete ${contact.name}?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Yes'),
              onPressed: () async {
                await DBHelper().deleteContact(contact.id!);
                Navigator.of(context).pop();
                _refreshContacts();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: _contactList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No contacts found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Contact contact = snapshot.data![index];
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _showDeleteDialog(contact),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Exit',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            _refreshContacts();
          } else if (index == 1) {
            _showAddDialog();
          } else if (index == 2) {
            Navigator.of(exit(0)).pop();
          }
        },
      ),
    );
  }
}
