import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Screens/login_screen.dart';
import 'package:instagram/Utils/colors.dart';
import 'package:instagram/Utils/image_picker.dart';
import 'package:instagram/Utils/snack_bar.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:instagram/widgets/app_logo.dart';
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
  Uint8List? image;
  bool isLoading = false;
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _userNamecontroller.dispose();

    super.dispose();
  }

  selectedImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = img;
        debugPrint("Image selected: ${image!.length} bytes");
      });
    } else {
      debugPrint("No image selected");
    }
  }

  void signupUser() async {
    setState(() {
      isLoading = true;
    });
    final response = await AuthMethod().signUpUser(
        userName: _userNamecontroller.text,
        email: _emailcontroller.text,
        bio: _biocontroller.text,
        password: _passwordcontroller.text);
    debugPrint('here is the reponse when signup hit $response');

    if (response != 'success' && mounted) {
      showSnackBar(response, context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Container(), flex: 2),
                const AppLogo(),
                const SizedBox(
                  height: 23,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: image != null
                          ? MemoryImage(image!) // Use the selected image
                          : const NetworkImage(
                              // Fallback to a default image
                              'https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.webp',
                            ) as ImageProvider,
                    ),
                    Positioned(
                        top: 85,
                        left: 90,
                        child: IconButton(
                            onPressed: selectedImage,
                            icon: const Icon(Icons.add_a_photo)))
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
                  onTap: signupUser,
                  child: Ink(
                    // alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                        color: blueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    width: double.infinity,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color:
                                      Colors.white), // Optional: Set text color
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
                      onTap: () {
                        debugPrint('inside log in gesture detector');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
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
          ),
        ),
      )),
    );
  }
}
