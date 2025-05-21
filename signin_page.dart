import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double headerHeight = screenHeight * 0.35;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior:
                  Clip.none, // Allows children to draw outside its bounds
              children: [
                Container(
                  color: const Color(0xFFFF008A), // Pink header background
                  height: headerHeight,
                  padding: const EdgeInsets.fromLTRB(
                    30,
                    0,
                    30,
                    30,
                  ), // Top padding set to 0 to allow image to go higher
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            height: 10,
                          ), // Adjust this to move text down from very top
                          Text(
                            "Style in your way using",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "LookWise..",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // THE GIRL CUTOUT IMAGE
                Positioned(
                  top: screenHeight * 0.18,
                  right: 0,
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/images/girls_cutout.png',
                    fit: BoxFit.contain,
                  ),
                ),
                // NEW: PROFILE ICON ADDED HERE
                Positioned(
                  top: 60, // Distance from the top of the Stack (header)
                  right: 30, // Distance from the right of the Stack (header)
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25, // Adjust radius as needed
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Image(
                        image: AssetImage(
                          'assets/images/profile_icon_design.png',
                        ), // Ensure this asset exists
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // White container for the form section - now sits directly below the Stack
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Color(0xFFFF008A),
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    height: 55,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xFFC0C0C0),
                        ),
                        hintText: "E-mail",
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 55,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFFC0C0C0),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password logic
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to features page upon sign-in
                        Navigator.pushNamed(context, '/features');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF008A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "or",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Implement Google Sign Up/Sign In logic
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 20,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Sign Up with Google",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account? ",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the sign-up page
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xFF673AB7),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
