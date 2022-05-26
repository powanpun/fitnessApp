import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/resources/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ForgotPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Fitness App",
                style: GoogleFonts.lato(
                    fontSize: 36, fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Column(children: [
                _textInput(emailController, "Recovery Email", Icons.email),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        resetPassword(emailController.text);
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
                        child: const Text("R E C O V E R",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () => {Navigator.pop(context)},
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Sign In",
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
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text(' Ops!'),
                content: Text('${e.message}'),
              ));
      return;
    }

    const snackBar = SnackBar(
      content: Text('Please check your email'),
    );

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Widget _textInput(controller, hint, icon) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular((8))),
      color: Colors.white,
    ),
    padding: const EdgeInsets.only(left: 10),
    child: TextFormField(
      style: GoogleFonts.lato(),
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: GoogleFonts.lato(),
        prefixIcon: Icon(icon),
      ),
    ),
  );
}
