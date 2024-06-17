import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/laptop_store_view_model.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laptop Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-laptop');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by model',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<LaptopStoreViewModel>(
                builder: (context, viewModel, child) {
                  var filteredLaptops = viewModel.laptops.where((laptop) =>
                      laptop.model.toLowerCase().contains(
                          _searchController.text.trim().toLowerCase()));

                  return ListView.builder(
                    itemCount: filteredLaptops.length,
                    itemBuilder: (context, index) {
                      var laptop = filteredLaptops.elementAt(index);
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(laptop.model, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Price: \$${laptop.price}, Thin: ${laptop.thin ? "Yes" : "No"}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              viewModel.removeLaptop(laptop.model);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
