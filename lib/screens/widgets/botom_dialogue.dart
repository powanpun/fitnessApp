import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resources/appcolors.dart';

Future<void> BottomDialog(
    BuildContext context, String title, String description) {
  return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title,
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor)),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  description,
                  style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: AppColors.secondaryColor),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        );
      });
}
