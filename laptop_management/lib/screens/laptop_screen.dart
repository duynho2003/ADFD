import 'package:flutter/material.dart';
import 'package:laptop_management/database/database_service.dart';
import 'package:laptop_management/models/laptop.dart';
import 'package:laptop_management/widgets/laptop_card.dart';

class LaptopScreen extends StatefulWidget {
  const LaptopScreen({super.key});

  @override
  State<LaptopScreen> createState() => _LaptopScreenState();
}

class _LaptopScreenState extends State<LaptopScreen> {
  var dbService = DatabaseService();
  var modelTextController = TextEditingController();
  var priceNumController = TextEditingController();
  bool _thin = false;

  //hien thi phan khung input
  void showLaptopBottomSheet(String functionName, Function()? onPressed) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 160),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Model'),
                    controller: modelTextController,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Price'),
                    controller: priceNumController,
                  ),
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
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      onPressed: onPressed, child: Text(functionName))
                ],
              ),
            ),
          );
        });
  }

  void _handleOnCreateLaptop() {
    showLaptopBottomSheet('Create', () {
      print('On Create Laptop');
      var model = modelTextController.text;
      var price = priceNumController.text;
      var thin = _thin;
      LaptopModel laptop = LaptopModel(
          id: UniqueKey().toString(),
          model: model,
          price: double.parse(price),
          thin: thin);
      dbService.insertLaptop(laptop);
      setState(() {
        modelTextController.text = '';
        priceNumController.text = '';
        thin = false;
      });
      Navigator.pop(context);
    });
  }

  void _handleOnDeleteLaptop(String id) {
    dbService.deleteLaptop(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Laptop Management')),
      body: FutureBuilder(
        future: dbService.getLaptops(),
        builder:
            (BuildContext context, AsyncSnapshot<List<LaptopModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data != null) {
            var listLaptops = snapshot.data!;
            if (listLaptops.isEmpty) {
              return Text('Laptop not found, perform add new');
            } else {
              return ListView.builder(
                  itemCount: listLaptops.length,
                  itemBuilder: (context, index) {
                    return LaptopCard(
                      item: listLaptops[index],
                      onItemDelete: _handleOnDeleteLaptop, //xoa
                    );
                  });
            }
          } else {
            return Text('Laptop not found or error occur!');
          }
        },
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: _handleOnCreateLaptop,
      ),
    );
  }
}
