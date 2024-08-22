import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget _buildEventsList(List<String> events) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MatchedPage()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Icon(Icons.image, color: Colors.white),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(events[index],
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Minneapolis',
                              style:
                                  GoogleFonts.montserrat(color: Colors.grey)),
                          Text('Thursday May 23 - 7:00pm',
                              style:
                                  GoogleFonts.montserrat(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      childCount: events.length,
    ),
  );
}
