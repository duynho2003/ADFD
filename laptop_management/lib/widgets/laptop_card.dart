import 'package:flutter/material.dart';
import 'package:laptop_management/models/laptop.dart';

class LaptopCard extends StatelessWidget {
  final LaptopModel item;
  final Function(String id)? onItemDelete;

  const LaptopCard(
      {super.key, required this.item, this.onItemDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Model: ${item.model} - Price: \$ ${item.price}'),
        subtitle: Text('Thin: ${item.thin ? "Yes" : "No"}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  print('Delete Laptop');
                  if (onItemDelete != null) {
                    onItemDelete!(item.id);
                  }
                },
                icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}