import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UndertoneSelectionPage extends StatefulWidget {
  const UndertoneSelectionPage({super.key});

  @override
  State<UndertoneSelectionPage> createState() => _UndertoneSelectionPageState();
}

class _UndertoneSelectionPageState extends State<UndertoneSelectionPage> {
  String? selectedUndertone;

  final List<String> undertones = [
    "Warm",
    "Cool",
    "Neutral",
  ];

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _saveUndertoneAndProceed() async {
    if (selectedUndertone == null) {
      setState(() {
        _errorMessage = "Please select an undertone.";
      });
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
        _errorMessage = "User not authenticated.";
        _isLoading = false;
      });
      return;
    }

    try {
      await supabase.from('user_selections').upsert({
        'user_id': user.id,
        'undertone': selectedUndertone,
      });
      if (mounted) {
        Navigator.pushNamed(context, '/features');
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to save selection: $e";
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Which undertone best characterizes your shape?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            ...undertones.map((tone) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedUndertone = tone;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                    color: selectedUndertone == tone
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
                      Text(
                        tone,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
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
            const Spacer(),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveUndertoneAndProceed,
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
