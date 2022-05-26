import 'dart:async';

import 'package:fitnessapp/datamodels/workout_model.dart';
import 'package:fitnessapp/repository/client_repo.dart';
import 'package:fitnessapp/resources/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutDetailPage extends StatefulWidget {
  final List<WorkoutModel> data;
  const WorkoutDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  late Timer _timer;
  int _startTime = 0;
  int currentIndex = 0;
  bool btnClickable = true;
  bool next = false;
  bool finish = false;
  String btnText = "Ready to go";
  String _email = '';

  _loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email') ?? '');
    });
  }

  void startTimer() {
    setState(() {
      btnText = "On going";
      btnClickable = false;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_startTime == 0) {
          setState(() {
            btnText = "Next";
            next = true;
            btnClickable = true;
            timer.cancel();

            showRestDialogue();
          });
        } else {
          setState(() {
            _startTime--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _loadEmail();
    _startTime = int.parse(widget.data[currentIndex].duration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
            flex: 1,
            child: Lottie.network(widget.data[currentIndex].image,
                repeat: true, frameRate: FrameRate(24)),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.data[currentIndex].title,
                    style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainColor, width: 2),
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.grey.shade100),
                  child: Text(_startTime.toString(),
                      style: GoogleFonts.lato(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor)),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => {
              if (btnClickable)
                {
                  if (finish)
                    {Navigator.of(context).pop()}
                  else
                    {
                      if (next)
                        {
                          if (currentIndex == widget.data.length - 1)
                            {
                              setState(
                                () {
                                  finish = true;
                                  btnText = "Done";
                                },
                              ),
                              successDialogue()
                            }
                          else
                            {
                              setState(() {
                                currentIndex = currentIndex + 1;
                                btnText = "Ready to go";
                                next = false;
                                _startTime = int.parse(
                                    widget.data[currentIndex].duration);
                              }),
                            }
                        }
                      else
                        {
                          setState(() {
                            _startTime =
                                int.parse(widget.data[currentIndex].duration);
                          }),
                          startTimer()
                        }
                    }
                }
              else
                {}
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.mainColor,
              ),
              child: Text(btnText,
                  style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white)),
            ),
          )
        ]),
      ),
    );
  }

  void showRestDialogue() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Take a rest.",
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                )),
            content: Text("${widget.data[currentIndex].rest} seconds",
                style: GoogleFonts.lato(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
          );
        });
  }

  void successDialogue() {
    ClientRepository clientRepository = ClientRepository();
    clientRepository.addWorkoutSuccessQty(_email, 100);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Congratulation",
                style: GoogleFonts.lato(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
            content: Text("You have completed this session successfully",
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                )),
          );
        });
  }
}
