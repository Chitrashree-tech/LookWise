import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateProfilePage extends StatefulWidget {
  final String userId;
  final String email;
  final String phone;

  const CreateProfilePage({
    super.key,
    required this.userId,
    required this.email,
    required this.phone,
  });

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _dobController = TextEditingController();
  String selectedGender = "Female";
  bool _isLoading = false;
  String _errorMessage = '';
  final _supabase = Supabase.instance.client;

  @override
  void dispose() {
    _fullNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _createProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _supabase.from('user_profiles').insert({
        'user_id': widget.userId,
        'email': widget.email,
        'phone': widget.phone,
        'full_name': _fullNameController.text.trim(),
        'dob': _dobController.text.trim(),
        'gender': selectedGender,
      });

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/body_type');
      }
    } on PostgrestException catch (error) {
      setState(() {
        _errorMessage = 'Failed to save profile: ${error.message}';
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred: $error';
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header
              Container(
                color: const Color(0xFFFF008A),
                padding: EdgeInsets.fromLTRB(30, statusBarHeight + 20, 24, 20),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "LookWise..",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.person, color: Color(0xFFFF008A)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  print("Tap to add/change profile image");
                },
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFFE0E0E0),
                  child: Icon(Icons.person, size: 60, color: Color(0xFFBDBDBD)),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Email (readonly)
                    buildReadonlyField(Icons.email, "E-mail", widget.email),
                    const SizedBox(height: 12),
                    // Phone (readonly)
                    buildReadonlyField(Icons.phone, "Phone Number", widget.phone),
                    const SizedBox(height: 12),
                    // Full Name
                    buildTextField(Icons.person, "Full Name", _fullNameController,
                        validator: (value) =>
                        value == null || value.isEmpty ? "Enter full name" : null),
                    const SizedBox(height: 12),
                    // Date of Birth
                    TextFormField(
                      controller: _dobController,
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                        prefixIcon: const Icon(Icons.cake, color: Colors.black),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty ? "Enter date of birth" : null,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          _dobController.text =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    // Gender
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "Gender",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        genderOption("Male"),
                        const SizedBox(width: 12),
                        genderOption("Female"),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Create Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _createProfile,
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
                          "Create",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
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
    );
  }

  Widget buildReadonlyField(IconData icon, String label, String value) {
    return TextFormField(
      initialValue: value,
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black),
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildTextField(IconData icon, String label, TextEditingController controller,
      {String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black),
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget genderOption(String gender) {
    bool isSelected = selectedGender == gender;
    return InkWell(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: isSelected ? Colors.purpleAccent : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.purpleAccent),
            ),
            child: isSelected
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 6),
          Text(gender),
        ],
      ),
    );
  }
}
