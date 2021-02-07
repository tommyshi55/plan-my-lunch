import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_frontend/views/components/already_have_an_account_check.dart';
import 'package:mobile_frontend/views/components/background.dart';
import 'package:mobile_frontend/views/components/rounded_button.dart';
import 'package:mobile_frontend/views/components/rounded_input_field.dart';
import 'package:mobile_frontend/views/components/rounded_password_field.dart';
import 'package:mobile_frontend/views/screens/main/main_screen.dart';
import 'package:mobile_frontend/views/screens/login/components/or_divider.dart';
import 'package:mobile_frontend/views/screens/login/components/social_icon.dart';
import 'package:mobile_frontend/views/screens/signup/sign_up_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              'assets/icons/login.svg',
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: 'Your Email',
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: 'LOGIN',
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    print(user);
                    Navigator.pushNamed(context, MainScreen.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  // TODO: add error handling
                  print(e);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.id);
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  iconSrc: 'assets/icons/facebook.svg',
                  onPressed: () {},
                ),
                SocialIcon(
                  iconSrc: 'assets/icons/google-plus.svg',
                  onPressed: () async {
                    try {
                      setState(() {
                        showSpinner = true;
                      });

                      final GoogleSignInAccount googleSignInAccount =
                          await googleSignIn.signIn();
                      final GoogleSignInAuthentication
                          googleSignInAuthentication =
                          await googleSignInAccount.authentication;

                      final AuthCredential credential =
                          GoogleAuthProvider.credential(
                        accessToken: googleSignInAuthentication.accessToken,
                        idToken: googleSignInAuthentication.idToken,
                      );

                      final UserCredential authResult =
                          await _auth.signInWithCredential(credential);
                      final User user = authResult.user;

                      if (user != null) {
                        print("Google sign in successful");
                        Navigator.pushNamed(context, MainScreen.id);
                      }
                    } catch (e) {
                      // TODO: Show error message
                      print(e);
                    } finally {
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
