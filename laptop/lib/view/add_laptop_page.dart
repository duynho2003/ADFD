import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/laptop.dart';
import '../viewmodel/laptop_store_view_model.dart';

class AddLaptopPage extends StatefulWidget {
  @override
  _AddLaptopPageState createState() => _AddLaptopPageState();
}

class _AddLaptopPageState extends State<AddLaptopPage> {
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _thin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Laptop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _modelController,
              decoration: InputDecoration(
                labelText: 'Model',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Thin'),
                Switch(
                  value: _thin,
                  onChanged: (value) {
                    setState(() {
                      _thin = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String model = _modelController.text;
                double price = double.tryParse(_priceController.text) ?? 0.0;
                if (model.isNotEmpty && price > 0) {
                  var laptop = Laptop(model: model, price: price, thin: _thin);
                  Provider.of<LaptopStoreViewModel>(context, listen: false)
                      .saveLaptop(laptop);
                  Navigator.pop(context);
                }
              },
              child: Text('Add Laptop'),
            ),
          ],
        ),
      ),
    );
  }
}
