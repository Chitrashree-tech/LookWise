import 'package:flutter/material.dart';

import 'body_type_selection.dart';
import 'create_profile.dart';
import 'face_shape_selection_page.dart';
import 'features_options_page.dart'; // Assuming this defines FeaturePage
import 'home_screen.dart';
import 'otp_verification.dart';
import 'profile_page.dart';
import 'screens/daily_outfit_suggestions_page.dart';
import 'screens/restyle_my_wardrode_page.dart'; // Corrected filename/route name
import 'screens/shop_daily_clothing_page.dart';
import 'screens/shop_for_occasions_page.dart';
import 'signin_page.dart';
// Ensure these imports point to the correct files in your project structure
// If your files are directly in 'lib/', the paths like 'signup_page.dart' are correct.
import 'signup_page.dart';
import 'undertone_selection_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LookWise',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const SignUpPage(), // Ensure SignUpPage constructor is const
      routes: {
        '/restyle_my_wardrobe':
            (context) => const RestyleMyWardrobePage(), // Added const
        '/shop_for_occasions':
            (context) => const ShopForOccasionsPage(), // Added const
        '/daily_outfit_suggestions':
            (context) => const DailyOutfitSuggestionsPage(), // Added const
        '/shop_daily_clothing':
            (context) => const ShopDailyClothingPage(), // Added const
        '/signup': (context) => const SignUpPage(), // Added const
        '/signin': (context) => const SignInPage(), // Added const
        '/otp_verification':
            (context) => const OTPVerificationPage(), // Added const
        '/create_profile':
            (context) => const CreateProfilePage(), // Added const
        '/body_type': (context) => const BodyTypeSelectionPage(), // Added const
        '/face_shape':
            (context) => const FaceShapeSelectionPage(), // Added const
        '/undertone':
            (context) => const UndertoneSelectionPage(), // Added const
        '/features':
            (context) =>
                FeaturePage(), // Added const (assuming FeaturePage has a const constructor)
        '/home': (context) => const HomeScreen(), // Added const
        '/profile': (context) => const ProfilePage(), // Added const
      },
    );
  }
}
