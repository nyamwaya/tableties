class Password {
  String passwordId;
  bool requiresReset;

  Password({
    required this.passwordId,
    required this.requiresReset,
  });

  factory Password.fromJson(Map<String, dynamic> json) {
    return Password(
      passwordId: json['password_id'],
      requiresReset: json['requires_reset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password_id': passwordId,
      'requires_reset': requiresReset,
    };
  }
}
