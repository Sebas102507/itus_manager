import 'package:flutter/material.dart';

import '../../constant/strings.dart';

class SearchButton extends StatelessWidget {

  void Function()? onPressed;

  SearchButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child:  Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  Strings.searchTitle,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Icon(Icons.search,color: Colors.white,size: 30)
              )

            ],
          )
      ),
    );
  }
}
