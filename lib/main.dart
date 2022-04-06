import 'package:fire_chat/navigation/navigator_key.dart';
import 'package:fire_chat/screens/homepage.dart';
import 'package:fire_chat/screens/login_screen.dart';
import 'package:fire_chat/screens/registration_screen.dart';
import 'package:fire_chat/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FireChat());
}

GlobalKey<NavigatorState>? navigatorKey = NavigationKey.navigatorKey;

class FireChat extends StatelessWidget {
  FireChat({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool authCheck() {
    if (_auth.currentUser == null) {
      false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: authCheck() ? HomePage.id : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomePage.id: (context) => HomePage(),
        // SettingsScreen.id: (context) => SettingsScreen(),
        // ChatWithFriend.id: (context) => ChatWithFriend()
      },
    );
  }
}
