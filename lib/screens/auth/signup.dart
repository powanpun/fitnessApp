import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/repository/client_repo.dart';
import 'package:fitnessapp/resources/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  var loading = false;
  bool _isObscure = true;

  var maxNumberLength = 10;
  var numberLength = 0;

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
              Text("Fitness App",
                  style: GoogleFonts.lato(
                      fontSize: 36, fontWeight: FontWeight.bold)),
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
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    style: GoogleFonts.lato(),
                    controller: usernameController,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 0.1),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.1),
                      ),
                      hintText: "Full Name",
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
                        return 'Please enter email';
                      } else {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text)) {
                          return 'Invalid email';
                        } else {
                          return null;
                        }
                      }
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
                      prefixIcon: const Icon(Icons.email),
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
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password must contain atleast 6 characters';
                      } else {
                        if (value != passwordController.text) {
                          return 'Password doesnot match';
                        }

                        return null;
                      }
                    },
                    obscureText: _isObscure,
                    maxLength: 20,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: GoogleFonts.lato(),
                    controller: rePasswordController,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 0.1),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.1),
                      ),
                      counterText: "",
                      hintText: "Retype Password",
                      hintStyle: GoogleFonts.lato(),
                      prefixIcon: const Icon(Icons.create_rounded),
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            _register();
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
                          child: const Text("S I G N  U P",
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
                                text: "  Sign In",
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

  void _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      _registerUser();
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

  void _registerUser() async {
    ClientRepository clientRepository = ClientRepository();
    try {
      clientRepository.singUpUser(
          usernameController.text, emailController.text);
      setState(() {
        loading = false;
      });
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text('Sucessfully Register.You Can Login Now'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text(' Ops! something Went Wrong'),
                content: Text('${e.message}'),
              ));
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
}
