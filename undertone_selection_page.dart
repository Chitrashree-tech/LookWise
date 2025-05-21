import 'package:flutter/material.dart';

import 'find_undertone_page.dart'; // <--- ADD THIS IMPORT!

class UndertoneSelectionPage extends StatefulWidget {
  const UndertoneSelectionPage({super.key});

  @override
  State<UndertoneSelectionPage> createState() => _UndertoneSelectionPageState();
}

class _UndertoneSelectionPageState extends State<UndertoneSelectionPage> {
  String? selectedUndertone;

  final List<String> undertones = ["Warm", "Cool", "Neutral"];

  @override
  Widget build(BuildContext context) {
    // Get the height of the system status bar (where clock, battery are)
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      // Removed SafeArea to allow the header to extend to the very top edge
      body: Column(
        children: [
          Container(
            color: const Color(0xFFFF008A),
            // Adjusted padding to account for the status bar height.
            padding: EdgeInsets.fromLTRB(24, statusBarHeight + 20, 24, 20),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Removed 'const' because the Image is not const
                const Icon(Icons.menu, color: Colors.white),
                const Text(
                  "LookWise..",
                  style: TextStyle(
                    fontSize: 20, // Changed font size to 20
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // Removed fontStyle: FontStyle.italic
                  ),
                ),
                const CircleAvatar(
                  // Added const for CircleAvatar
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Image(
                      image: AssetImage(
                        'assets/images/profile_icon_design.png',
                      ), // Changed to profile_icon_design.png
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: const Text(
              // Removed const from here to allow nested const Text if needed (good practice)
              "Which undertone best characterizes your shape?", // Clarify this text if this page is for body shape
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ), // Changed font size to 20
            ),
          ),
          const SizedBox(height: 20),
          // This loop builds your selectable "undertone" options
          ...undertones.map(
            (tone) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedUndertone = tone;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                    color:
                        selectedUndertone == tone
                            ? Colors.grey.shade200
                            : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selectedUndertone == tone
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: const Color(0xFFFF008A),
                      ),
                      const SizedBox(width: 16),
                      Text(tone, style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FindUndertonePage(),
                    ),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Unsure about your undertone? ",
                    children: [
                      TextSpan(
                        text: "Click here!",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Spacer(), // Added Spacer to push content up
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/features');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF008A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Go to Next Page",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
