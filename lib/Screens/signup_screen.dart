import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/Utils/colors.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:instagram/widgets/text_field_input.dart';
import 'package:instagram/resources/auth_method.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _userNamecontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 2),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 45,
            ),
            const SizedBox(
              height: 23,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp'),
                ),
                Positioned(
                    top: 85,
                    left: 90,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.add_a_photo)))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldInput(
              controller: _userNamecontroller,
              hinttext: 'Enter Your User Name',
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              controller: _biocontroller,
              hinttext: 'Enter Your Bio',
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
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
              onTap: () async {
                final response = await AuthMethod().signUpUser(
                    userName: _userNamecontroller.text,
                    email: _emailcontroller.text,
                    bio: _biocontroller.text,
                    password: _passwordcontroller.text);
                debugPrint('here is the reponse when signup hit $response');
              },
              child: Ink(
                // alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                width: double.infinity,
                child: const Center(
                  child: Text(
                    'Sign Up',
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
                  child: const Text("Already have an account?"),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Log in.",
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
