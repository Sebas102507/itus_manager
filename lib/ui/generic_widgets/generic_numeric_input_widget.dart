import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../themes/colors.dart';




class GenericNumberInputWidget extends StatelessWidget {

  TextEditingController controller;
  Color backgroudColor;
  Color shadowColor;
  String title;

  GenericNumberInputWidget({Key? key, required this.controller,
    required this.backgroudColor,required this.shadowColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroudColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: lightGrey.withOpacity(0.3),width: 1.5),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child:TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: darkGrey,
          ),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
                top: 15
            ),
            hintText: title,
            hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey
            ),
            enabledBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: backgroudColor),
            ),
            focusedBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: backgroudColor),
            ),
            border:  UnderlineInputBorder(
              borderSide: BorderSide(color: backgroudColor),
            ),
          ),
        )
    );

  }

}
