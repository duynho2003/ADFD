class UserModel {
  final String id;
  final String name;
  final String email;
  final int age;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.age});

  factory UserModel.formJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        age: json['age'] as int);
  }

  Map<String, dynamic> toMap() =>
      {'id': id, 'name': name, 'email': email, 'age': age};
}
