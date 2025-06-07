import 'package:flutter/material.dart';

import 'find_body_type_page.dart'; // <--- ADD THIS IMPORT

class BodyTypeSelectionPage extends StatefulWidget {
  const BodyTypeSelectionPage({super.key});

  @override
  State<BodyTypeSelectionPage> createState() => _BodyTypeSelectionPageState();
}

class _BodyTypeSelectionPageState extends State<BodyTypeSelectionPage> {
  String? selectedBodyType;
  String? selectedSize;

  final List<String> bodyTypes = [
    "Hourglass",
    "Triangle",
    "Rectangle",
    "Pear",
    "Inverted Triangle",
  ];

  final List<String> sizes = ["XS", "S", "M", "L", "XL"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFFF008A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Removed 'const' here because CircleAvatar contains a non-const Image
                  const Icon(Icons.menu, color: Colors.white),
                  const Text(
                    // Keep 'const' here if the Text itself is const
                    "LookWise..",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const CircleAvatar(
                    // Keep 'const' here if CircleAvatar and its children can be const
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Image(
                        image: AssetImage(
                          'assets/images/profile_icon_design.png',
                        ),
                      ),
                    ), // Corrected: This was missing a closing parenthesis ')'
                  ), // Corrected: This was an extra closing parenthesis ')'
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Which body type best characterizes your shape?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 25),
            ...bodyTypes.map(
              (type) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 6,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBodyType = type;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                      color:
                          selectedBodyType == type
                              ? Colors.grey.shade200
                              : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selectedBodyType == type
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: const Color(0xFFFF008A),
                        ),
                        const SizedBox(width: 12),
                        Text(type, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(left: 24, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose your Size / Fit :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    sizes.map((size) {
                      final isSelected = selectedSize == size;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? const Color(0xFFFF008A)
                                      : Colors.grey.shade400,
                            ),
                            color:
                                isSelected
                                    ? const Color(0xFFFF008A).withOpacity(0.1)
                                    : Colors.white,
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected
                                      ? const Color(0xFFFF008A)
                                      : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FindBodyTypePage(),
                      ),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Unsure about your body type? ",
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/face_shape');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF008A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Go to Next Page",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
