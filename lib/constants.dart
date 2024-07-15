// lib/constants.dart

class AppConstants {
  static const String _obfuscatedApiKey = 'UshA0Bx1Zs9YavR3t2MqulWXyQMnbf';

  static String getApiKey() {
    return _deobfuscate(_obfuscatedApiKey);
  }

  static String _deobfuscate(String obfuscated) {
    // Simple deobfuscation: reverse the string and remove every second character
    final reversed = obfuscated.split('').reversed.join('');
    return reversed.replaceAllMapped(
      RegExp(r'.{2}'),
      (match) => match.group(0)![0],
    );
  }
}
