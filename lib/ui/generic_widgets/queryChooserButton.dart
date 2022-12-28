import 'package:flutter/material.dart';

import '../../constant/strings.dart';
import '../../themes/colors.dart';

class QueryChooserButton extends StatefulWidget {

  void Function()? onPressed;
  bool isSelected;
  bool isDocument;


  QueryChooserButton({Key? key,required this.onPressed,required this.isSelected,required this.isDocument}) : super(key: key);

  @override
  State<QueryChooserButton> createState() => _QueryChooserButtonState();
}


class _QueryChooserButtonState extends State<QueryChooserButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
          //backgroundColor: (widget.isDocumentSelected) ? mainOrange : Colors.white,
          backgroundColor: (widget.isSelected) ? mainOrange : Colors.white,
          side: BorderSide(
              color: (widget.isSelected) ? mainOrange : lightGrey
          )
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          (widget.isDocument)?Strings.queryForDocument: Strings.queryForName,
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: (widget.isSelected) ? Colors.white : lightGrey, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

