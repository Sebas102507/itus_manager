import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itus_manager/themes/colors.dart';

import '../../constant/strings.dart';



class PasswordInput extends StatefulWidget {
  TextEditingController controllerEmail;
  Color backgroudColor;
  Color shadowColor;
  bool seePassword;

  PasswordInput({Key? key, required this.controllerEmail,
    required this.backgroudColor,
    required this.shadowColor,
    required this.seePassword});

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroudColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: lightGrey.withOpacity(0.3),width: 1.5),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: TextFormField(
              controller: widget.controllerEmail,
              obscureText: widget.seePassword,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: darkGrey,
              ),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: Strings.passwordText,
                hintStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey
                ),
                enabledBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.backgroudColor),
                ),
                focusedBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.backgroudColor),
                ),
                border:  UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.backgroudColor),
                ),
              ),
            )
          ),
          Expanded(
              flex: 1,
              child: IconButton(
                  icon: Icon(
                    widget.seePassword ? Icons.remove_red_eye_outlined:Icons.remove_red_eye,
                    color: lightGrey,
                    size: 30),
                  onPressed: (){
                      setState(() {
                        if(widget.seePassword){widget.seePassword=false;}
                        else{widget.seePassword=true;}
                      });
                  })
          )
        ],
      ),
    );

  }
}
