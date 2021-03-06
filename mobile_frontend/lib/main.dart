import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_frontend/business_logic/models/user_plan.dart';
import 'package:mobile_frontend/views/constants.dart';
import 'package:mobile_frontend/views/screens/login/login_screen.dart';
import 'package:mobile_frontend/views/screens/main/main_screen.dart';
import 'package:mobile_frontend/views/screens/search_restaurants/search_restaurant_screen.dart';
import 'package:mobile_frontend/views/screens/signup/sign_up_screen.dart';
import 'package:mobile_frontend/views/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserPlan(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          MainScreen.id: (context) => MainScreen(),
          SearchRestaurantScreen.id: (context) => SearchRestaurantScreen(),
        },
      ),
    );
  }
}
