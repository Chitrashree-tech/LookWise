import 'package:flutter/material.dart';

class FaceShapeSelectionPage extends StatefulWidget {
  const FaceShapeSelectionPage({super.key});

  @override
  State<FaceShapeSelectionPage> createState() =>
      _FaceShapeSelectionPageState();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color(0xFFFF008A),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.menu, color: Colors.white),
                  Text(
                    "LookWise..",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(Icons.face, color: Color(0xFFFF008A)),
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
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Which face shape describes you the best?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ...faceShapes.map((shape) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedShape = shape;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12),
                            color: selectedShape == shape
                                ? Colors.grey.shade200
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectedShape == shape
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                                color: Color(0xFFFF008A),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                shape,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(height: 16),
                    const Text.rich(
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
                    const SizedBox(height: 40),
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
                    backgroundColor: Color(0xFFFF008A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Go to Next Page",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
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