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
            'Upcoming',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'To provide you with the best service, we need you to complete your profile. '
                    'Please provide the following information:\n${_formatMissingFields(missingInterests)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
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
                        'Complete Profile Setup',
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
