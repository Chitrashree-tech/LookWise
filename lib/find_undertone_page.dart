// lib/find_undertone_page.dart
import 'package:flutter/material.dart';

class FindUndertonePage extends StatelessWidget {
  const FindUndertonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF008A),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ), // Menu icon from your previous page
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Find your Undertone",
              style: TextStyle(fontSize: 20, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildUndertoneCard(
              context,
              'assets/images/cool_veins.png', // Make sure this path is correct
              'Cool',
              'If your veins look bluish, then you may have cool undertones.',
            ),
            const SizedBox(height: 20),
            _buildUndertoneCard(
              context,
              'assets/images/warm_veins.png', // Make sure this path is correct
              'Warm',
              'If your veins look greenish, then you may have warm undertones.',
            ),
            const SizedBox(height: 20),
            _buildUndertoneCard(
              context,
              'assets/images/neutral_veins.png', // Make sure this path is correct
              'Neutral',
              'If your veins look colorless or may appear as a mix of both blue and green, then you may have warm undertones.',
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  ); // Go back to the previous page (UndertoneSelectionPage)
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

  Widget _buildUndertoneCard(
    BuildContext context,
    String imagePath,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image takes up about 1/3 of the width
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25, // Adjust as needed
            height:
                MediaQuery.of(context).size.width * 0.25, // Keep aspect ratio
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Ensures image covers the space
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
