import 'package:fitnessapp/datamodels/challenges_model.dart';
import 'package:fitnessapp/datamodels/workout_model.dart';
import 'package:fitnessapp/repository/client_repo.dart';
import 'package:fitnessapp/resources/appcolors.dart';
import 'package:fitnessapp/route/router.dart';
import 'package:fitnessapp/screens/widgets/botom_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutPage extends StatefulWidget {
  final ChallengesModel data;
  const WorkoutPage({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String _email = '';
  late List<WorkoutModel> data;
  final ClientRepository clientRepository = ClientRepository();

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
          child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Image.network(
                  widget.data.image,
                  fit: BoxFit.cover,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(widget.data.title,
                        style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<List<WorkoutModel>>(
                stream: clientRepository.getWorkoutData(
                  widget.data.title.toLowerCase().replaceAll(' ', ''),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    data = snapshot.data!;
                    return ListView.builder(
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => {
                              BottomDialog(context, snapshot.data![index].title,
                                  snapshot.data![index].description)
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Lottie.network(
                                        snapshot.data![index].image,
                                        repeat: true,
                                        frameRate: FrameRate(24)),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(snapshot.data![index].title,
                                                style: GoogleFonts.lato(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .secondaryColor)),
                                            Text(
                                                "x ${snapshot.data![index].duration}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: AppColors
                                                        .secondaryColor)),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      )),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.mainColor,
          onPressed: () {
            clientRepository.addWorkoutQty(_email);
            Navigator.pushNamed(context, workoutDetailPageRoute,
                arguments: data);
          },
          elevation: 0,
          label: const Text(
            "Start",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
