import 'package:flutter/material.dart';
import 'package:lookwise_app/identify_face_shape_page.dart'; // <--- ADD THIS IMPORT

class FaceShapeSelectionPage extends StatefulWidget {
  const FaceShapeSelectionPage({super.key});

  @override
  State<FaceShapeSelectionPage> createState() => _FaceShapeSelectionPageState();
}

class _FaceShapeSelectionPageState extends State<FaceShapeSelectionPage> {
  String? selectedShape;

  final List<String> faceShapes = [
    "Round",
    "Square",
    "Diamond",
    "Heart",
    "Oval",
  ];

  @override
  Widget build(BuildContext context) {
    // Get the height of the system status bar (where clock, battery are)
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      // Removed SafeArea from here in previous iterations to allow header to extend to top
      body: Column(
        children: [
          Container(
            color: const Color(0xFFFF008A), // Added const
            // Adjusted padding to include statusBarHeight at the top
            // This makes the pink header extend to the very top of the screen.
            padding: EdgeInsets.fromLTRB(24, statusBarHeight + 20, 24, 20),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      "Which face shape describes you the best?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ...faceShapes.map(
                    (shape) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedShape = shape;
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
                                selectedShape == shape
                                    ? Colors.grey.shade200
                                    : Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectedShape == shape
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                                color: const Color(0xFFFF008A), // Added const
                              ),
                              const SizedBox(width: 12),
                              Text(shape, style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IdentifyFaceShapePage(),
                        ),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Unsure about your face shape? ",
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
                  const SizedBox(height: 0),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/undertone');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF008A), // Added const
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
