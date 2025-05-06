import 'package:flutter/material.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  String selectedGender = "Female";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xFFFF008A),
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "LookWise..",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    buildInputField(Icons.email, "E-mail"),
                    const SizedBox(height: 12),
                    buildInputField(Icons.phone, "Phone Number"),
                    const SizedBox(height: 12),
                    buildInputField(Icons.person, "Full Name"),
                    const SizedBox(height: 12),
                    buildInputField(Icons.cake, "Date of Birth"),
                    const SizedBox(height: 20),
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
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/body_type');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF008A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Create",
                          style: TextStyle(fontSize: 18),
                        ),
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

  Widget buildInputField(IconData icon, String hint) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: hint == "E-mail" || hint == "Phone Number"
            ? Colors.grey[700]
            : Colors.grey[300],
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.black),
        hintStyle: TextStyle(
          color: hint == "E-mail" || hint == "Phone Number"
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.bold,
        ),
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
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 6),
          Text(gender),
        ],
      ),
    );
  }
}