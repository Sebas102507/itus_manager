import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/strings.dart';
import '../../provider/itus_response_provider.dart';
import '../../provider/query_provider.dart';
import '../../themes/colors.dart';
import '../generic_widgets/searchButton.dart';

class FrecuentQuestionsScreen extends StatefulWidget {
  FrecuentQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<FrecuentQuestionsScreen> createState() => _FrecuentQuestionsScreenState();
}

class _FrecuentQuestionsScreenState extends State<FrecuentQuestionsScreen> {

  String campanasnValue = 'Alojamiento';
  String cicloNegocionValue = 'Alojamiento';
  String preguntasValue = 'Alojamiento';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.frecuentQuestionsTitle,
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.black,fontSize: 16),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Consumer<QueryProvider>(
        builder: (context, query, child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:  Text(
                      "${query.currentQueryUser.name} ${query.currentQueryUser.lastname}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.black,fontSize: 20),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),

                Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      color: lightGrey.withOpacity(0.1),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: searchItemDropDown("Campañas"),
                          ),
                          Expanded(
                            flex: 2,
                            child: searchItemDropDown("Ciclo de negocio"),
                          ),
                          Expanded(
                            flex: 2,
                            child: searchItemDropDown("Preguntas"),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                          child: SearchButton(
                                            onPressed: (){
                                          },
                                          )
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(),
                                    )
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                    )
                ),

                Expanded(
                  flex: 3,
                  child: Container()
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget searchItemDropDown(String title){
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: lightGrey.withOpacity(0.3),width: 1.5),
              color: Colors.white,
            ),
            child:  DropdownButton<String>(
                isExpanded: true,
                value: campanasnValue,
                items: Provider.of<ItusResponseProvider>(context, listen: false).itusResponse!.itusUser.ciclo.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child:  Text(
                      items,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    campanasnValue = newValue!;
                  });
                }
            ),
          ),
        )
      ],
    );

  }


}

