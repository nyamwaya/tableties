import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchedPage extends StatelessWidget {
  const MatchedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: "You've\n"),
                        TextSpan(
                            text: "Matched ",
                            style: TextStyle(color: Colors.black)),
                        WidgetSpan(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'Let\'s celebrate with a party emoji '),
                                TextSpan(
                                  text: '🎉',
                                  style: TextStyle(fontSize: 24),
                                ),
                                TextSpan(text: ' instead of an image.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle FAQs button press
                    },
                    child: Text('FAQs',
                        style: GoogleFonts.montserrat(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.location_on, '1010 W Lake Street'),
                      _buildInfoRow(Icons.calendar_today, 'Tonight, at 7:30pm'),
                      _buildInfoRow(Icons.people, '6 People'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Attendees:',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildAttendeeCard('Bill Rizer', 'Planet Designer', Colors.teal),
              _buildAttendeeCard(
                  'Genbei Yagy', 'Planet Designer', Colors.deepOrange),
              _buildAttendeeCard('Lancy Neo', 'Rogue Corp', Colors.pink),
              _buildAttendeeCard('Bill Rizer', 'Hard Cops', Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.amber),
          SizedBox(width: 10),
          Text(text, style: GoogleFonts.montserrat()),
          Spacer(),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildAttendeeCard(String name, String occupation, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(name[0], style: TextStyle(color: color)),
        ),
        title: Text(name,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(occupation,
            style:
                GoogleFonts.montserrat(color: Colors.white.withOpacity(0.8))),
      ),
    );
  }
}
