import 'package:flutter/material.dart';
import 'package:user_management/models/user.dart';

class UserCard extends StatelessWidget {
  final UserModel item;
  final Function(UserModel user)? onItemEdit;
  final Function(String id)? onItemDelete;

  const UserCard(
      {super.key, required this.item, this.onItemEdit, this.onItemDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Name: ${item.name} - Age: ${item.age}'),
        subtitle: Text('Email: ${item.email}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  print('Edit User');
                  if (onItemEdit != null) {
                    onItemEdit!(item);
                  }
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  print('Delete User');
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
