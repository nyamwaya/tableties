class Email {
  String email;
  String emailId;
  bool verified;

  Email({
    required this.email,
    required this.emailId,
    required this.verified,
  });

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      email: json['email'],
      emailId: json['email_id'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'email_id': emailId,
      'verified': verified,
    };
  }
}
