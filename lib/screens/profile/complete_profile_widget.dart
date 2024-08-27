import 'package:flutter/material.dart';

class CompleteProfileWidget extends StatelessWidget {
  final List<String>? missingInterests;

  const CompleteProfileWidget({Key? key, required this.missingInterests})
      : super(key: key);

  String _formatMissingFields(List<String>? fields) {
    if (fields == null) return '';
    return fields.map((field) {
      if (field == 'photo') return 'profile picture';
      if (field == 'user_interests') return 'interests';
      return field;
    }).join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upcoming Dinners',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Almost there! Complete your profile by adding a ${_formatMissingFields(missingInterests)} to unlock personalized dinners.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement finish profile setup functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(
                        'Unlock Personalized Dinners',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
