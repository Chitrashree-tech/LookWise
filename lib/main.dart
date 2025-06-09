import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
import 'screens/chatbot_page.dart';
import 'profile_page.dart';
import 'identify_face_shape_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://iqsxlvjnmccmheqvtqvc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlxc3hsdmpubWNjbWhlcXZ0cXZjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyMjkwMDgsImV4cCI6MjA2MjgwNTAwOH0.FrbOze1f8gUKJ0GHn7pfz1B1nKaKuk1JFM2jiJh8LYI',
  );

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
      // Always start with HomeScreen
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(), // HomeScreen is now the root route
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
        '/body_type': (context) => const BodyTypeSelectionPage(),
        '/face_shape': (context) => const FaceShapeSelectionPage(),
        '/undertone': (context) => const UndertoneSelectionPage(),
        '/features': (context) => FeaturePage(),
        '/home': (context) => const HomeScreen(), // Optional if needed elsewhere
        '/profile': (context) => const ProfilePage(),
        '/restyle_my_wardrobe': (context) => const RestyleMyWardrobePage(),
        '/shop_for_occasions': (context) => const ShopForOccasionsPage(),
        '/daily_outfit_suggestions': (context) => const DailyOutfitSuggestionsPage(),
        '/shop_daily_clothing': (context) => const ShopDailyClothingPage(),
        '/chatbot': (context) => const ChatbotPage(),
        '/identifyFace': (context) => const IdentifyFaceShapePage(),

      },
    );
  }
}