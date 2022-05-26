import 'package:fitnessapp/datamodels/challenges_model.dart';
import 'package:fitnessapp/repository/client_repo.dart';
import 'package:fitnessapp/route/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../resources/appcolors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ClientRepository clientRepository = ClientRepository();

  var controller;

  @override
  void initState() {
    controller = PageController(
      viewportFraction: 0.8,
    );
    super.initState();
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
            Text("Start Your ",
                style: GoogleFonts.lato(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor)),
            Row(
              children: [
                Text("Fitness",
                    style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor)),
                const SizedBox(
                  width: 8,
                ),
                Text("Journey",
                    style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor)),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text("Challenges",
                style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor)),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder<List<ChallengesModel>>(
                stream: clientRepository.getAllChallenges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 2.2,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                            padEnds: false,
                            controller: controller,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, workoutRoute,
                                        arguments: snapshot.data![index]);
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Stack(
                                        fit: StackFit.passthrough,
                                        children: [
                                          Image.network(
                                            snapshot.data![index].image,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                  snapshot.data![index].title,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          alignment: Alignment.bottomLeft,
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: snapshot.data!.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: AppColors.mainColor,
                              dotColor: Colors.grey.shade200,
                              radius: 8,
                              spacing: 8,
                              dotHeight: 4,
                              dotWidth: 12,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            Text("Popular Exercises",
                style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor)),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder<List<ChallengesModel>>(
                stream: clientRepository.getAllWorkOuts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            margin: const EdgeInsets.only(bottom: 8),
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, workoutRoute,
                                    arguments: snapshot.data![index]);
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                      child: Image.network(
                                        snapshot.data![index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    height: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data![index].title,
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.secondaryColor)),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.local_fire_department,
                                              color: AppColors.mainColor,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text("200 k/cl",
                                                style: GoogleFonts.lato(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
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
                                              color: AppColors.mainColor,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text("20 mins per day",
                                                style: GoogleFonts.lato(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
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
                                              Icons.wb_sunny,
                                              color: AppColors.mainColor,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text("7 days",
                                                style: GoogleFonts.lato(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .secondaryColor)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      )),
    ));
  }
}
//challenges
//diets
//most liked routines
