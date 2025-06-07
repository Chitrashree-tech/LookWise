import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Fallback background color
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/background.png", // Ensure this path is correct and image is in pubspec.yaml
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // 🔷 Pink Header Section
                Container(
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  color: const Color(
                    0xFFFF008A,
                  ).withOpacity(0.9), // Pink with increased transparency
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // LookWise Logo (assuming it's an asset)
                                Image.asset(
                                  "assets/logo.png", // Path to your 'LookWise' logo asset
                                  height: 60, // Adjusted height for better fit
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "A personalised virtual stylist",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 22,
                                    fontFamily:
                                        'OpenSans', // Example font, ensure it's in pubspec.yaml
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Profile Icon (moved here from AppBar)
                          InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, '/profile'); // Example navigation
                            },
                            child: CircleAvatar(
                              radius: 35, // Larger radius for visibility
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/profile_icon_design.png", // Path to your profile icon asset
                                  fit: BoxFit.cover,
                                  width: 70, // Matches radius * 2
                                  height: 70, // Matches radius * 2
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Sign In / Sign Up removed from header, moved to bottom
                    ],
                  ),
                ),

                // 🔷 "Style Made Just for You!" Section
                Container(
                  width: double.infinity,
                  color: Colors.white.withOpacity(
                    0.7,
                  ), // White with transparency to show background
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  child: Text(
                    "Style Made Just for You!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFFF008A),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          'Lato', // Example font, ensure it's in pubspec.yaml
                    ),
                  ),
                ),

                // 🔷 Feature Descriptions Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  // No specific background color here, letting Stack handle it
                  child: Column(
                    children: [
                      _buildFeatureDescription(
                        context,
                        "Weather-Based Outfit Suggestions",
                      ),
                      _buildFeatureDescription(
                        context,
                        "Find trendy outfits within your price range",
                      ),
                      _buildFeatureDescription(
                        context,
                        "Get personalized recommendations from Amazon, Flipkart, Myntra & more.",
                      ),
                      const SizedBox(
                        height: 30,
                      ), // Space before Sign In/Sign Up
                    ],
                  ),
                ),

                // 🔷 Sign In / Sign Up Choices (at the bottom)
                Container(
                  width: double.infinity,
                  color:
                      Colors
                          .transparent, // No explicit background, let Stack handle it
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(
                            0.9,
                          ), // Transparent white
                          foregroundColor: const Color(0xFFFF008A), // Pink text
                          side: const BorderSide(
                            color: Color(0xFFFF008A),
                            width: 1.5,
                          ), // Pink border
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ), // Rounded corners
                          ),
                          elevation: 0, // No shadow
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(
                            0.9,
                          ), // Transparent white
                          foregroundColor: const Color(0xFFFF008A), // Pink text
                          side: const BorderSide(
                            color: Color(0xFFFF008A),
                            width: 1.5,
                          ), // Pink border
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ), // Rounded corners
                          ),
                          elevation: 0, // No shadow
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Padding at the very bottom
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildFeatureDescription(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: null, // Set onPressed to null to disable button interaction
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(
            0.9,
          ), // White with transparency
          foregroundColor: const Color(0xFFFF008A),
          side: const BorderSide(
            color: Color(0xFFFF008A),
            width: 1.5,
          ), // Pink border
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Highly rounded corners
          ),
          elevation: 0, // No shadow
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'OpenSans',
          ), // Example font
        ),
      ),
    );
  }
}
