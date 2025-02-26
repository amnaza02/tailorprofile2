import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/customer_list.dart';

class TailorProfilePage extends StatefulWidget {
  const TailorProfilePage({super.key});

  @override
  TailorProfilePageState createState() => TailorProfilePageState();
}

class TailorProfilePageState extends State<TailorProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200], // Background color of the page
      body: SingleChildScrollView( // Enables scrolling if needed
        child: Column(
          children: [
            // Stack to display cover image and profile picture
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // Cover image
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/6.jpg'), // Cover image
                      fit: BoxFit.cover, // Covers the entire container
                    ),
                  ),
                ),
                // Profile picture positioned over the cover image
                Positioned(
                  bottom: -40, 
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 3), // White border around the profile picture
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'images/2.jpg', // Profile picture
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50), 

            // Username text
            Text(
              "Username",
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            // Tailor description
            Text(
              "Skilled tailor creating custom clothing with a perfect fit and unique style.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),

            // Button to open customer list page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                _buildTextButton(context, const CustomerList()), // Navigation button to customer list
                const SizedBox(width: 10),
              ],
            ),

            const Divider(), // Separator line

            // Message indicating where  posts will be displayed
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                "Your uploaded work will appear here.", // Informational message
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  button  navigates to Customer list
  Widget _buildTextButton(BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 163, 119, 178), // Button color
        ),
        child: Text(
          "Customer", // Button text
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
