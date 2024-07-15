import 'package:TableTies/models/email_model.dart';
import 'package:TableTies/models/name_model.dart';
import 'package:TableTies/models/password_model.dart';

class User {
  List<dynamic> biometricRegistrations;
  String createdAt;
  List<dynamic> cryptoWallets;
  List<Email> emails;
  Name name;
  Password password;
  List<dynamic> phoneNumbers;
  List<dynamic> providers;
  String status;
  List<dynamic> totps;
  Map<String, dynamic> trustedMetadata;
  Map<String, dynamic> untrustedMetadata;
  String userId;
  List<dynamic> webauthnRegistrations;

  User({
    required this.biometricRegistrations,
    required this.createdAt,
    required this.cryptoWallets,
    required this.emails,
    required this.name,
    required this.password,
    required this.phoneNumbers,
    required this.providers,
    required this.status,
    required this.totps,
    required this.trustedMetadata,
    required this.untrustedMetadata,
    required this.userId,
    required this.webauthnRegistrations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      biometricRegistrations: json['biometric_registrations'] ?? [],
      createdAt: json['created_at'],
      cryptoWallets: json['crypto_wallets'] ?? [],
      emails: List<Email>.from(json['emails'].map((x) => Email.fromJson(x))),
      name: Name.fromJson(json['name']),
      password: Password.fromJson(json['password']),
      phoneNumbers: json['phone_numbers'] ?? [],
      providers: json['providers'] ?? [],
      status: json['status'],
      totps: json['totps'] ?? [],
      trustedMetadata: json['trusted_metadata'] ?? {},
      untrustedMetadata: json['untrusted_metadata'] ?? {},
      userId: json['user_id'],
      webauthnRegistrations: json['webauthn_registrations'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'biometric_registrations': biometricRegistrations,
      'created_at': createdAt,
      'crypto_wallets': cryptoWallets,
      'emails': List<dynamic>.from(emails.map((x) => x.toJson())),
      'name': name.toJson(),
      'password': password.toJson(),
      'phone_numbers': phoneNumbers,
      'providers': providers,
      'status': status,
      'totps': totps,
      'trusted_metadata': trustedMetadata,
      'untrusted_metadata': untrustedMetadata,
      'user_id': userId,
      'webauthn_registrations': webauthnRegistrations,
    };
  }
}
