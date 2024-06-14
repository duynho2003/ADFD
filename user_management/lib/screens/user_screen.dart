import 'package:flutter/material.dart';
import 'package:user_management/database/database_service.dart';

import '../models/user.dart';
import '../widgets/user_card.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var dbService = DatabaseService();
  var nameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var ageTextController = TextEditingController();

  void showUserBottomSheet(String functionName, Function()? onPressed) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 160),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Name of User'),
                    controller: nameTextController,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Name of Email'),
                    controller: emailTextController,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Name of Age'),
                    controller: ageTextController,
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

  void _handelOnCreateUser() {
    showUserBottomSheet('Create', () {
      print('On Create User');
      var name = nameTextController.text;
      var email = emailTextController.text;
      var age = ageTextController.text;
      UserModel user = UserModel(
          id: UniqueKey().toString(),
          name: name,
          email: email,
          age: int.parse(age));
      dbService.insertUser(user);
      setState(() {
        nameTextController.text = '';
        emailTextController.text = '';
        ageTextController.text = '';
      });
      Navigator.pop(context);
    });
  }

  void _handleOnEditUser(UserModel user) {
    nameTextController.text = user.name;
    emailTextController.text = user.email;
    ageTextController.text = '${user.age}';
    showUserBottomSheet('Update', () {
      print('On Edit User');
      var name = nameTextController.text;
      var email = emailTextController.text;
      var age = ageTextController.text;
      UserModel userEdit =
          UserModel(id: user.id, name: name, email: email, age: int.parse(age));
      dbService.updateUser(userEdit);
      setState(() {
        nameTextController.text = '';
        emailTextController.text = '';
        ageTextController.text = '';
      });
      Navigator.pop(context);
    });
  }

  void _handleOnDeleteUser(String id) {
    dbService.deleteUser(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Management')),
      body: FutureBuilder(
        future: dbService.getUsers(),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data != null) {
            var listUsers = snapshot.data!;
            if (listUsers.isEmpty) {
              return Text('User not found, perform add new');
            } else {
              return ListView.builder(
                  itemCount: listUsers.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      item: listUsers[index],
                      onItemEdit: _handleOnEditUser,
                      onItemDelete: _handleOnDeleteUser,
                    );
                  });
            }
          } else {
            return Text('User not found or error occur!');
          }
        },
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: _handelOnCreateUser,
      ),
    );
  }
}
