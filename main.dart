import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'signin_page.dart';
import 'otp_verification.dart';
import 'create_profile.dart';
import 'body_type_selection.dart';
import 'face_shape_selection_page.dart';
import 'undertone_selection_page.dart';
import 'features_options_page.dart';
import 'home_screen.dart';
import 'screens/shop_daily_clothing_page.dart';
import 'screens/daily_outfit_suggestions_page.dart';
import 'screens/shop_for_occasions_page.dart';
import 'screens/restyle_my_wardrode_page.dart';
import 'profile_page.dart';
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
      home: SignUpPage(), // This line determines the first page to run
      routes: {
        '/restyle_my_wardrobe':(context) => const RestyleMyWardrobePage(),
        '/shop_for_occasions': (context) => const ShopForOccasionsPage(),
        '/daily_outfit_suggestions': (context) => const DailyOutfitSuggestionsPage(),
        '/shop_daily_clothing': (context) => const ShopDailyClothingPage(),
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
        '/otp_verification': (context) => const OTPVerificationPage(),
        '/create_profile': (context) => const CreateProfilePage(),
        '/body_type': (context) => const BodyTypeSelectionPage(),
        '/face_shape': (context) => const FaceShapeSelectionPage(),
        '/undertone': (context) => const UndertoneSelectionPage(),
        '/features': (context) => FeaturePage(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}