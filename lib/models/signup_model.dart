class Data {
  final String email;
  final String password;
  final Name name;

  Data({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name.toJson(),
      };
}

class Name {
  final String firstName;

  Name({required this.firstName});

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
      };
}
