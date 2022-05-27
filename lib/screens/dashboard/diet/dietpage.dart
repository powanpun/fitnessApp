import 'package:fitnessapp/datamodels/diet_model.dart';
import 'package:fitnessapp/repository/client_repo.dart';
import 'package:fitnessapp/route/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/appcolors.dart';

class DietPage extends StatefulWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  final ClientRepository clientRepository = ClientRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Popular Diets",
                style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor)),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: StreamBuilder<List<DietModel>>(
                  stream: clientRepository.getAllDiets(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, dietPageRoute,
                                    arguments: snapshot.data![index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                height: 150,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      fit: StackFit.expand,
                                      children: [
                                        Image.network(
                                          snapshot.data![index].image,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            width: double.infinity,
                                            color: AppColors.bgLightBlack,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8),
                                              child: Text(
                                                  snapshot.data![index].title,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          });
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
