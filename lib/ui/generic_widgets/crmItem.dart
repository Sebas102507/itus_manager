import 'package:flutter/material.dart';
import '../../themes/colors.dart';

class CrmItem extends StatelessWidget {

  String ciclo_negocio;
  String medio;
  DateTime date;
  String resumen;
  int index;

  CrmItem(this.ciclo_negocio,this.medio,this.date,this.resumen,this.index, {super.key});

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
                  ciclo_negocio,
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
        ],
      ),
    );
  }
}
