import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../themes/colors.dart';

class OutBoundItem extends StatelessWidget {
  String title;
  String medio;
  DateTime date;
  String resumen;
  String messageLink;
  String token;
  int index;

  OutBoundItem(this.title, this.medio, this.date, this.resumen,
     this.messageLink, this.token, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      color: (index%2==0)?lightGrey.withOpacity(0.1):Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.black,fontSize: 14),
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "${date.year}-${date.month}-${date.day}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: mainGreen,fontSize: 14),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              medio,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: mainGreen,fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              resumen,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.black,fontSize: 12),
              textAlign: TextAlign.justify,
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 15
                ),
                child: RichText(
                  text: TextSpan(
                      text: "Ver mensaje",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: mainGreen,decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = ()async{
                          await Clipboard.setData(ClipboardData(text: token));
                          await launchUrl(Uri.parse(messageLink),);
                        }),
                ),
              )
          ),
        ],
      ),
    );
  }
}
