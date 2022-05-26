import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/repository/client_repo.dart';
import 'package:fitnessapp/resources/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({Key? key}) : super(key: key);

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final _formKey = GlobalKey<FormState>();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String dropdownGoal = "Weight Loss";
  bool isMale = true;
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  _loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email') ?? '');
    });
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Choose your gender",
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => {
                        setState(() {
                          isMale = true;
                        })
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.backgroundGrey2),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/man.png",
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text("Male ",
                                style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: isMale
                                        ? AppColors.mainColor
                                        : Colors.grey.shade400)),
                            //  currentTab == 2 ? Colors.green.shade900 : Colors.black54
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        setState(() {
                          isMale = false;
                        })
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.backgroundGrey2),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/woman.png",
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text("Female ",
                                style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: !isMale
                                        ? AppColors.mainColor
                                        : Colors.grey.shade400)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Text("Basic information",
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 16,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            return null;
                          },
                          style: GoogleFonts.lato(),
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.1),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.1),
                            ),
                            hintText: "Enter your age",
                            hintStyle: GoogleFonts.lato(),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your height';
                            }
                            return null;
                          },
                          style: GoogleFonts.lato(),
                          keyboardType: TextInputType.number,
                          controller: heightController,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.1),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.1),
                            ),
                            hintText: "Enter your height (cm)",
                            hintStyle: GoogleFonts.lato(),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your weight';
                            }
                            return null;
                          },
                          style: GoogleFonts.lato(),
                          keyboardType: TextInputType.number,
                          controller: weightController,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.1),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.1),
                            ),
                            hintText: "Enter your weight (kg)",
                            hintStyle: GoogleFonts.lato(),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text("Select your goal",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          child: DropdownButton<String>(
                            value: dropdownGoal,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownGoal = newValue!;
                              });
                            },
                            items: <String>[
                              'Weight Loss',
                              'Build Muscle',
                              'Body Tone',
                              'Fitness'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    )),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (_formKey.currentState!.validate()) {
                        // showDialog(
                        //     barrierDismissible: false,
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AlertDialog(
                        //         title: Text("Please Wait",
                        //             style: GoogleFonts.lato(
                        //               fontSize: 24,
                        //               fontWeight: FontWeight.normal,
                        //             )),
                        //         content: const SizedBox(
                        //           height: 50,
                        //           width: 50,
                        //           child: FittedBox(
                        //               child: CircularProgressIndicator()),
                        //         ),
                        //       );
                        //     });
                        _setUserGoal();
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.mainColor,
                    ),
                    child: Text("Proceed",
                        style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setUserGoal() {
    ClientRepository clientRepository = ClientRepository();

    try {
      clientRepository.addUserGoal(_email, dropdownGoal);
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Congratulation",
                  style: GoogleFonts.lato(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
              content:
                  Text("Please check your recommendation page to view detail.",
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      )),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Oops Something went wrong",
                  style: GoogleFonts.lato(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
              content: Text(e.toString(),
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  )),
            );
          });
    }
  }
}
