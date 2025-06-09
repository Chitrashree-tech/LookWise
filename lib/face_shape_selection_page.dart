import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FaceShapeSelectionPage extends StatefulWidget {
  const FaceShapeSelectionPage({super.key});

  @override
  State<FaceShapeSelectionPage> createState() => _FaceShapeSelectionPageState();
}

class _FaceShapeSelectionPageState extends State<FaceShapeSelectionPage> {
  String? selectedShape;
  final List<String> faceShapes = ["Round", "Square", "Diamond", "Heart", "Oval"];
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _saveFaceShapeAndProceed() async {
    if (selectedShape == null) {
      setState(() => _errorMessage = "Please select a face shape.");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        _errorMessage = "You are not signed in. Please log in again.";
        _isLoading = false;
      });
      return;
    }

    try {
      await supabase.from('user_selections').upsert({
        'user_id': user.id,
        'face_shape': selectedShape,
      });
      if (mounted) {
        Navigator.pushNamed(context, '/undertone');
      }
    } catch (e) {
      setState(() => _errorMessage = "Failed to save: ${e.toString()}");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: const Color(0xFFFF008A),
            padding: EdgeInsets.fromLTRB(24, statusBarHeight + 20, 24, 20),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.menu, color: Colors.white),
                Text(
                  "LookWise..",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      "Which face shape describes you the best?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ...faceShapes.map((shape) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedShape = shape);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                          color: selectedShape == shape ? Colors.grey.shade200 : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              selectedShape == shape
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: const Color(0xFFFF008A),
                            ),
                            const SizedBox(width: 12),
                            Text(shape, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/identifyFace');
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
                  const SizedBox(height: 20),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
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
                onPressed: _isLoading ? null : _saveFaceShapeAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF008A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : const Text(
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
