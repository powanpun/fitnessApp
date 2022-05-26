import 'package:fitnessapp/datamodels/challenges_model.dart';
import 'package:fitnessapp/datamodels/diet_model.dart';
import 'package:fitnessapp/datamodels/user_model.dart';
import 'package:fitnessapp/repository/client_repo.dart';
import 'package:fitnessapp/resources/appcolors.dart';
import 'package:fitnessapp/route/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ClientRepository clientRepository = ClientRepository();
  String _email = '';
  String goal = '';

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          StreamBuilder<UserModel>(
              stream: clientRepository.getUserData(_email),
              builder: (context, data) {
                if (data.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome ${data.data!.fullName},",
                          style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor)),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Your Workout Plan",
                          style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor)),
                      const SizedBox(height: 16),
                      StreamBuilder<List<ChallengesModel>>(
                          stream:
                              clientRepository.getUserWorkOut(data.data!.goal),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                return const Text("No recommendation availabe");
                              }
                              return ListView.builder(
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      margin: const EdgeInsets.only(bottom: 8),
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, workoutRoute,
                                              arguments: snapshot.data![index]);
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8)),
                                                child: Image.network(
                                                  snapshot.data![index].image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              height: 150,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      snapshot
                                                          .data![index].title,
                                                      style: GoogleFonts.lato(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .secondaryColor)),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .local_fire_department,
                                                        color:
                                                            AppColors.mainColor,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text("200 k/cl",
                                                          style: GoogleFonts.lato(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .secondaryColor)),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.timer,
                                                        color:
                                                            AppColors.mainColor,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text("20 mins per day",
                                                          style: GoogleFonts.lato(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .secondaryColor)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                      const SizedBox(height: 16),
                      Text("Your Diet Plans",
                          style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor)),
                      const SizedBox(height: 16),
                      StreamBuilder<List<DietModel>>(
                          stream: clientRepository.getUserDiet(data.data!.goal),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                return const Text("No recommendation availabe");
                              }
                              return ListView.builder(
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      margin: const EdgeInsets.only(bottom: 8),
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, workoutRoute,
                                              arguments: snapshot.data![index]);
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8)),
                                                child: Image.network(
                                                  snapshot.data![index].image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              height: 150,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      snapshot
                                                          .data![index].title,
                                                      style: GoogleFonts.lato(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .secondaryColor)),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .local_fire_department,
                                                        color:
                                                            AppColors.mainColor,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text("200 k/cl",
                                                          style: GoogleFonts.lato(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .secondaryColor)),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.timer,
                                                        color:
                                                            AppColors.mainColor,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text("20 mins per day",
                                                          style: GoogleFonts.lato(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .secondaryColor)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ]),
      ),
    )));
  }
}
