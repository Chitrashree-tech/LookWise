import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _phoneOTPControllers =
  List.generate(4, (_) => TextEditingController());

  bool _isPhoneVerified = false;

  String get _phoneOTPCode =>
      _phoneOTPControllers.map((controller) => controller.text).join();

  Future<void> _verifyOTP(BuildContext context, String type) async {
    if (type == 'phone') {
      String otpCode = _phoneOTPCode;
      String apiUrl = 'YOUR_BACKEND_URL/verify-phone-otp'; // Adjust URL
      String userIdentifier = 'user@example.com'; // Adjust accordingly

      if (otpCode.length == 4) {
        try {
          final response = await http.post(
            Uri.parse(apiUrl),
            body: {
              'otp': otpCode,
              'identifier': userIdentifier,
            },
          );

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Phone OTP verified!')),
            );
            setState(() {
              _isPhoneVerified = true;
            });
            Navigator.pushNamed(context, '/create_profile'); // Navigate after successful phone verification
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Phone OTP. Please try again.')),
            );
          }
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to connect to the server.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter the complete Phone OTP.')),
        );
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _phoneOTPControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildInputRow(String hint, IconData trailingIcon) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Icon(trailingIcon, color: Colors.black),
      ],
    );
  }

  Widget buildOTPBoxes(String identifier) {
    if (identifier == 'phone') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return SizedBox(
            width: 50,
            height: 50,
            child: TextField(
              controller: _phoneOTPControllers[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                counterText: "",
              ),
              onChanged: (value) {
                if (value.length == 1 && index < 3) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          );
        }),
      );
    } else {
      return const SizedBox.shrink(); // Should not happen now
    }
  }

  Widget buildVerifyButton(BuildContext context, String type) {
    if (type == 'phone') {
      return ElevatedButton(
        onPressed: () => _verifyOTP(context, type),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purpleAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Text("Verify Phone OTP"),
        ),
      );
    } else {
      return const SizedBox.shrink(); // Should not happen now
    }
  }

  Widget buildResendText() {
    return Column(
      children: [
        const Text(
          "Didn’t receive a message? ",
          style: TextStyle(color: Colors.black54),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Resend OTP",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              color: Colors.pinkAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.menu, color: Colors.white),
                  Text(
                    "LookWise..",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(24),
                    height: constraints.maxHeight,
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "Phone Verification",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              const SizedBox(height: 30),
                              buildLabel("Phone Number"),
                              buildInputRow(
                                  "Enter Phone Number", Icons.check_circle_outline),
                              const SizedBox(height: 16),
                              buildOTPBoxes("phone"),
                              const SizedBox(height: 12),
                              buildVerifyButton(context, "phone"),
                              const SizedBox(height: 10),
                              buildResendText(),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}