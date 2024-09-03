import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      // Adjust padding as needed
      color: Colors.white, // Or any desired background color
      child: const Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align items to left and right
        children: [
          Row(
            // Group the pin and text together
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 8), // Add spacing between icon and text
              Text('Select A City',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Icon(Icons.notifications, color: Colors.orange),
        ],
      ),
    );
  }
}
