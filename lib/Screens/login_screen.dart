import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/Screens/signup_screen.dart';
import 'package:instagram/Utils/colors.dart';
import 'package:instagram/Utils/snack_bar.dart';
import 'package:instagram/widgets/app_logo.dart';
import 'package:instagram/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloading = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

    super.dispose();
  }

  Future<void> loginUser() async {
    setState(() {
      isloading = true;
    });
    try {
      if (_emailcontroller.text.isNotEmpty &&
          _passwordcontroller.text.isNotEmpty) {
        debugPrint('email and password are correct');
        UserCredential usercredential = await _auth.signInWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim(),
        );
        setState(() {
          isloading = true;
        });

        if (usercredential.user != null && mounted) {
          debugPrint(
              'user login successfully${usercredential.user!.email.toString()}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignupScreen(),
            ),
          );
        }
      } else {
        showSnackBar("Invalid Email or passwrod", context);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(e.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 2),
            const AppLogo(),
            const SizedBox(
              height: 40,
            ),
            TextFieldInput(
              controller: _emailcontroller,
              hinttext: 'Enter Your Email',
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              controller: _passwordcontroller,
              isPass: true,
              hinttext: 'Enter Your password  ',
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: loginUser,
              child: Ink(
                // alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                width: double.infinity,
                child: isloading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              color: Colors.white), // Optional: Set text color
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text("Don't have an account?"),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('inside sign up gesture detector');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Sign Up.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blueColor,
                          fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
          ],
        ),
      )),
    );
  }
}
