import 'package:flutter/material.dart';

import 'body_type_selection.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  String selectedGender = "Female"; // Default selection as seen in design

  @override
  Widget build(BuildContext context) {
    // Get the height of the system status bar (where clock, battery are)
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      // Removed SafeArea from here to allow the pink header to extend to the very top edge of the screen.
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section - Top Pink Bar
            Container(
              color: const Color(
                0xFFFF008A,
              ), // Pink header color matching design
              // Padding adjusted to account for the status bar height.
              // The 20 is additional padding for the content below the status bar.
              padding: EdgeInsets.fromLTRB(30, statusBarHeight + 20, 24, 20),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "LookWise..",
                    style: TextStyle(
                      fontSize: 22, // Font size for "LookWise.."
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic, // Removed italics as requested
                    ),
                  ),
                  // Small profile icon in top right corner
                  const CircleAvatar(
                    backgroundColor:
                        Colors.white, // White background for the avatar
                    radius: 20, // Smaller radius for the top-right icon
                    child: Padding(
                      padding: EdgeInsets.all(
                        5.0,
                      ), // Padding for the image inside the avatar
                      child: Image(
                        image: AssetImage(
                          'assets/images/profile_icon_design.png',
                        ), // Ensure this asset exists in your project
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60), // Spacing below the pink header
            // Main Profile Image Circle (User can add profile icon)
            // This is a placeholder for where a user's chosen profile image would appear.
            // You'd integrate image picking logic here (e.g., using image_picker package).
            GestureDetector(
              onTap: () {
                // TODO: Implement image picking logic (e.g., from gallery/camera)
                // For example: _pickImageFromGallery();
                print("Tap to add/change profile image");
              },
              child: const CircleAvatar(
                radius: 60, // Size of the main profile picture circle
                backgroundColor: Color(
                  0xFFE0E0E0,
                ), // Light grey background as seen in design
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Color(0xFFBDBDBD),
                ), // Grey person icon inside
              ),
            ),
            const SizedBox(height: 30), // Spacing below the profile image

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ), // Horizontal padding for the form fields
              child: Column(
                children: [
                  // E-mail Input Field (Darker background, white text)
                  buildInputField(Icons.email, "E-mail", isDark: true),
                  const SizedBox(height: 12), // Spacing between fields
                  // Phone Number Input Field (Darker background, white text)
                  buildInputField(Icons.phone, "Phone Number", isDark: true),
                  const SizedBox(height: 12), // Spacing between fields
                  // Full Name Input Field (Lighter background, black text)
                  buildInputField(Icons.person, "Full Name"),
                  const SizedBox(height: 12), // Spacing between fields
                  // Date of Birth Input Field (Lighter background, black text)
                  buildInputField(Icons.calendar_today, "Date of Birth"),
                  const SizedBox(height: 20), // Spacing before Gender section
                  // Gender Selection Section
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12, // Vertical padding for "Gender" label
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFE0E0E0,
                          ), // Light grey background for "Gender" label
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Matching border radius with text fields
                        ),
                        child: const Text(
                          "Gender",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Text color for "Gender"
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ), // Spacing between "Gender" label and options
                      genderOption("Male"), // Male radio button option
                      const SizedBox(
                        width: 12,
                      ), // Spacing between Male and Female options
                      genderOption("Female"), // Female radio button option
                    ],
                  ),
                  const SizedBox(height: 30), // Spacing before Create button
                  // Create Button
                  SizedBox(
                    width: double.infinity, // Button takes full width
                    height: 50, // Fixed height for the button
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BodyTypeSelectionPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFFF008A,
                        ), // Pink button background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ), // Rounded button corners
                        ),
                        elevation: 0, // No shadow for the button
                      ),
                      child: const Text(
                        "Create",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40), // Spacing at the bottom of the page
          ],
        ),
      ),
    );
  }

  // Helper method to build input fields with consistent styling
  Widget buildInputField(IconData icon, String hint, {bool isDark = false}) {
    return TextField(
      decoration: InputDecoration(
        filled: true, // Enable fill color
        fillColor:
            isDark
                ? const Color(0xFF757575)
                : const Color(0xFFE0E0E0), // Dark grey or light grey background
        hintText: hint, // Placeholder text
        prefixIcon: Icon(
          icon,
          color: isDark ? Colors.white : Colors.black,
        ), // Icon color based on background
        hintStyle: TextStyle(
          color:
              isDark
                  ? Colors.white
                  : Colors.black, // Hint text color based on background
          fontWeight: FontWeight.bold, // Bold hint text
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ), // Consistent border radius for fields
          borderSide: BorderSide.none, // No visible border line
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ), // Adjust padding for vertical centering of text
      ),
    );
  }

  // Helper method to build gender radio button options
  Widget genderOption(String gender) {
    bool isSelected = selectedGender == gender;

    return Expanded(
      // Use Expanded to make the gender options take up available space equally
      child: InkWell(
        onTap: () {
          setState(() {
            selectedGender = gender; // Update selected gender on tap
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ), // Padding for the clickable area
          decoration: BoxDecoration(
            color: const Color(
              0xFFE0E0E0,
            ), // Light grey background for the options
            borderRadius: BorderRadius.circular(12), // Matching border radius
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .center, // Center the icon and text within the option
            children: [
              Container(
                height: 20, // Size of the circular indicator
                width: 20,
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? const Color(0xFF9C27B0) // Purple color if selected
                          : Colors.transparent, // Transparent if not selected
                  shape: BoxShape.circle, // Circular shape
                  border: Border.all(
                    color:
                        isSelected
                            ? const Color(
                              0xFF9C27B0,
                            ) // Purple border if selected
                            : Colors.grey, // Grey border if not selected
                    width: 2, // Border thickness
                  ),
                ),
                child:
                    isSelected
                        ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        ) // Check icon if selected
                        : null, // No icon if not selected
              ),
              const SizedBox(width: 8), // Spacing between circle and text
              Text(
                gender,
                style: const TextStyle(
                  color: Colors.black, // Text color for gender option
                  fontWeight: FontWeight.normal, // Normal font weight
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
