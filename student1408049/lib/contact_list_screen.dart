import 'package:flutter/material.dart';
import 'laptop_db.dart';
import 'add_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Map<String, dynamic>> _laptops = [];
  List<Map<String, dynamic>> _filteredLaptops = [];
  TextEditingController _searchController = TextEditingController();
  final LaptopDB _laptopDB = LaptopDB();

  @override
  void initState() {
    super.initState();
    _loadLaptops();
    _searchController.addListener(_filterLaptops);
  }

  Future<void> _loadLaptops() async {
    final laptops = await LaptopDB().getLaptops();
    setState(() {
      _laptops = laptops;
      _filteredLaptops = laptops;
    });
  }

  void _deleteLaptop(int id) async {
    await _laptopDB.deleteLaptop(id);  // Use the instance to call the method
    _loadLaptops();
  }

  void _filterLaptops() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      final filtered = _laptops.where((contact) {
        final name = contact['name'] as String;
        return name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        _filteredLaptops = filtered;
      });
    } else {
      setState(() {
        _filteredLaptops = _laptops;
      });
    }
  }

  void _add() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddScreen()),
    ).then((_) => _loadLaptops());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laptops'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _add,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLaptops.length,
              itemBuilder: (context, index) {
                final laptop = _filteredLaptops[index];
                return ListTile(
                  title: Text(_filteredLaptops[index]['name']),
                  subtitle: Text(_filteredLaptops[index]['price']),
                  trailing: IconButton( // Add delete button
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteLaptop(laptop['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
