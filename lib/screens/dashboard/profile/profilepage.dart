import 'package:fitnessapp/datamodels/user_model.dart';
import 'package:fitnessapp/repository/client_repo.dart';
import 'package:fitnessapp/resources/appcolors.dart';
import 'package:fitnessapp/route/router.dart';
import 'package:fitnessapp/screens/widgets/botom_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ClientRepository clientRepository = ClientRepository();
  String _email = '';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: StreamBuilder<UserModel>(
              stream: clientRepository.getUserData(_email),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     ClipRRect(
                      //       borderRadius: BorderRadius.circular((200)),
                      //       child: Image.asset(
                      //         "assets/noimage.jpg",
                      //         fit: BoxFit.cover,
                      //         height: 150,
                      //         width: 150,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              snapshot.data!.fullName,
                              style: GoogleFonts.lato(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              snapshot.data!.email,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.backgroundGrey2,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.local_fire_department,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${snapshot.data!.caloriesBurnt.toString()} kcl",
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.backgroundGrey2,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.alarm_sharp,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data!.started.toString(),
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.backgroundGrey2,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.alarm_on_sharp,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      snapshot.data!.completed.toString(),
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // const SizedBox(
                      //   height: 32,
                      // ),
                      // InkWell(
                      //   onTap: () => {},
                      //   child: Container(
                      //     width: double.infinity,
                      //     padding: const EdgeInsets.all(16),
                      //     decoration: BoxDecoration(
                      //         color: AppColors.backgroundGrey2,
                      //         borderRadius: BorderRadius.circular(8)),
                      //     child: const Text("Edit Profile",
                      //         style: TextStyle(
                      //           fontSize: 16,
                      //         )),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 32,
                      ),
                      InkWell(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Reset Achievements'),
                            content: const Text('Are you sure?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => resetAchievements(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColors.backgroundGrey2,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text("Reset Achievements",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          BottomDialog(context, "About Us", "description");
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColors.backgroundGrey2,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text("About Us",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          BottomDialog(
                              context, "Terms and Conditions", "description");
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColors.backgroundGrey2,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text("Terms and Conditions",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          BottomDialog(
                              context, "Privacy Policy", "description");
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColors.backgroundGrey2,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text("Privacy Policy",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, loginPageRoute)
                        },
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: AppColors.backgroundGrey2,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text("Log Out",
                                style: TextStyle(
                                  fontSize: 16,
                                ))),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  resetAchievements() {
    clientRepository.resetAchievements(_email);
    Navigator.pop(context);
  }
}
