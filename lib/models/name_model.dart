class Name {
  String firstName;
  String lastName;
  String middleName;

  Name({
    required this.firstName,
    required this.lastName,
    required this.middleName,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstName: json['first_name'],
      lastName: json['last_name'],
      middleName: json['middle_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
    };
  }
}
