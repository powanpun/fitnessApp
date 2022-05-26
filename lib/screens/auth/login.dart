import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/resources/appcolors.dart';
import 'package:fitnessapp/route/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure = true;
  var loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    "Ultimate Fitness Tracking and Nutrition Guidance App",
                    style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor)),
              ),
              const SizedBox(
                height: 40,
              ),
              Visibility(
                visible: loading,
                child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(20),
                    child: LinearProgressIndicator(
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                      backgroundColor: Colors.grey.shade100,
                      color: AppColors.mainColor,
                      minHeight: 2,
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter registered email or mobile number';
                      }
                      return null;
                    },
                    style: GoogleFonts.lato(),
                    controller: emailController,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 0.1),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.1),
                      ),
                      hintText: "Email",
                      hintStyle: GoogleFonts.lato(),
                      prefixIcon: const Icon(Icons.account_box),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password must contain atleast 6 characters';
                      }
                      return null;
                    },
                    maxLength: 20,
                    obscureText: _isObscure,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: GoogleFonts.lato(),
                    controller: passwordController,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 0.1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.1),
                        ),
                        hintText: "Password",
                        counterText: "",
                        hintStyle: GoogleFonts.lato(),
                        prefixIcon: const Icon(Icons.vpn_key),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.pushNamed(context, forgotPasswordRoute),
                    },
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.centerRight,
                        child: const Text("Forgot Password ?")),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              _signInWithEmailAndPassword();
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.mainColor,
                                  AppColors.mainColor
                                ],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          alignment: Alignment.center,
                          child: const Text("L O G I N",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.pushNamed(context, signupPageRoute),
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: " Register",
                                style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold))
                          ])),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      setState(() {
        loading = false;
      });
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      try {
        await prefs.setString('email', emailController.text);
      } on Exception catch (e) {
        print("error ${e.toString()}");
      }
      Navigator.pushReplacementNamed(context, bottomNavigationRoute);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text(' Ops! Registration Failed'),
                content: Text('${e.message}'),
              ));
      setState(() {
        loading = false;
      });
    }
  }
}
