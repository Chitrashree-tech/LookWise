// lib/identify_face_shape_page.dart
import 'package:flutter/material.dart';

class IdentifyFaceShapePage extends StatelessWidget {
  const IdentifyFaceShapePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF008A),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white), // Menu icon
          onPressed: () {
            // Implement drawer or other menu functionality here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menu action not implemented yet')),
            );
          },
        ),
        title: const Text(
          "LookWise..",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              // <--- 'child:' keyword is missing here
              backgroundColor: Colors.white,
              radius: 20,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Image(
                  image: AssetImage('assets/images/profile_icon_design.png'),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Identify Your Face Shape Now!",
              style: TextStyle(fontSize: 20, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Row for Oval and Square
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFaceShapeExample('assets/images/face_oval.png', 'OVAL'),
                _buildFaceShapeExample(
                  'assets/images/face_square.png',
                  'SQUARE',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Center for Heart
            _buildFaceShapeExample('assets/images/face_heart.png', 'HEART'),
            const SizedBox(height: 20),
            // Row for Round and Diamond
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFaceShapeExample('assets/images/face_round.png', 'ROUND'),
                _buildFaceShapeExample(
                  'assets/images/face_diamond.png',
                  'DIAMOND',
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF008A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Return to previous page",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceShapeExample(String imagePath, String label) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 120, // Adjust height as needed
          width: 120, // Adjust width as needed, keep aspect ratio
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 80, color: Colors.grey);
          },
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
