// lib/find_body_type_page.dart
import 'package:flutter/material.dart';

class FindBodyTypePage extends StatefulWidget {
  const FindBodyTypePage({super.key});

  @override
  State<FindBodyTypePage> createState() => _FindBodyTypePageState();
}

class _FindBodyTypePageState extends State<FindBodyTypePage> {
  final TextEditingController _bustController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _highHipController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  bool _isInch = true; // true for inches, false for cm

  String _calculatedSize = "N/A";
  String _calculatedBodyType = "N/A";

  @override
  void dispose() {
    _bustController.dispose();
    _waistController.dispose();
    _highHipController.dispose();
    _hipController.dispose();
    super.dispose();
  }

  void _calculateBodyTypeAndSize() {
    double bust = double.tryParse(_bustController.text) ?? 0.0;
    double waist = double.tryParse(_waistController.text) ?? 0.0;
    double hip = double.tryParse(_hipController.text) ?? 0.0;

    // Convert to inches if currently in cm for consistent calculation logic
    if (!_isInch) {
      bust /= 2.54;
      waist /= 2.54;
      hip /= 2.54;
    }

    // Basic size calculation (very simplified example)
    // You would use actual size charts for this
    if (bust < 32 || waist < 24 || hip < 34) {
      _calculatedSize = "XS";
    } else if (bust < 34 || waist < 26 || hip < 36) {
      _calculatedSize = "S";
    } else if (bust < 36 || waist < 28 || hip < 38) {
      _calculatedSize = "M";
    } else if (bust < 38 || waist < 30 || hip < 40) {
      _calculatedSize = "L";
    } else {
      _calculatedSize = "XL";
    }

    // Body Type Calculation (simplified based on common ratios)
    // This is a basic example. Real-world body type calculation can be more complex.
    if (bust == 0 || waist == 0 || hip == 0) {
      _calculatedBodyType = "Enter measurements";
    } else {
      double shoulderOrBust = bust; // Using bust as a proxy for shoulders/bust
      double waistRatioToShoulderBust = waist / shoulderOrBust;
      double waistRatioToHip = waist / hip;

      if (waist < (shoulderOrBust * 0.75) && waist < (hip * 0.75)) {
        // Waist significantly smaller than bust/shoulders and hips
        _calculatedBodyType = "Hourglass";
      } else if (hip > (shoulderOrBust * 1.05)) {
        // Hips significantly wider than bust/shoulders
        _calculatedBodyType = "Pear (Triangle)";
      } else if (shoulderOrBust > (hip * 1.05)) {
        // Bust/shoulders significantly wider than hips
        _calculatedBodyType = "Inverted Triangle";
      } else if (waistRatioToShoulderBust > 0.75 &&
          waistRatioToHip > 0.75 &&
          (shoulderOrBust * 0.95 <= hip && shoulderOrBust * 1.05 >= hip)) {
        // Relatively straight up and down
        _calculatedBodyType = "Rectangle";
      } else {
        // Default or other types, consider more complex logic
        _calculatedBodyType = "Oval/Other";
      }
    }

    setState(() {}); // Update UI with calculated values
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF008A),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
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
              "Find your Body Type",
              style: TextStyle(fontSize: 20, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFFFF008A), width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildUnitToggle('inch', _isInch),
                  _buildUnitToggle('cm', !_isInch),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/body_measurements_diagram.png', // Your cropped image
              height: 200, // Adjust height as needed
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error_outline,
                  size: 100,
                  color: Colors.red,
                );
              },
            ),
            const SizedBox(height: 20),
            _buildMeasurementTextField(_bustController, "Bust Size"),
            const SizedBox(height: 16),
            _buildMeasurementTextField(_waistController, "Waist Size"),
            const SizedBox(height: 16),
            _buildMeasurementTextField(
              _highHipController,
              "High Hip Size (Optional)",
            ),
            const SizedBox(height: 16),
            _buildMeasurementTextField(_hipController, "Hip Size"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBodyTypeAndSize,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF008A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "Calculate",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFFF008A), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Based on our Analysis",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Size: $_calculatedSize",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Body Type: $_calculatedBodyType",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
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
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitToggle(String unit, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isInch = (unit == 'inch');
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF008A) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          unit.toUpperCase(),
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFFFF008A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMeasurementTextField(
      TextEditingController controller,
      String label,
      ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "$label (${_isInch ? 'inch' : 'cm'})",
        hintText: "Enter your $label",
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}