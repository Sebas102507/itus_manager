import 'package:flutter/material.dart';
import 'package:itus_manager/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../constant/strings.dart';
import '../../provider/query_provider.dart';

class CurrentBusinessHistoryScreen extends StatefulWidget {
  const CurrentBusinessHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CurrentBusinessHistoryScreen> createState() => _CurrentBusinessHistoryScreenState();
}

class _CurrentBusinessHistoryScreenState extends State<CurrentBusinessHistoryScreen> {

  String dropdownvalue = 'Outbound';
  List<String> historyOptions=["Outbound","Inbound","CRM"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.businessHistoryTitle,
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
                  flex: 8,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownvalue,
                                items: historyOptions.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child:  Text(
                                      items,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Center(
                                child: Icon(
                                  Icons.filter_alt,
                                  color: mainGreen,
                                  size: 25,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Center(
                                child: Icon(
                                  Icons.calendar_month,
                                  color: mainGreen,
                                  size: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: mainGreen,
                        thickness: 5,
                      ),
                      Expanded(
                        flex: 12,
                        child: Container(
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return historyItem(
                                    "Operador de información",
                                    "SMS",
                                    "Abr 8. de 2022",
                                    """kaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfladkaldlkfmalkdfla
                                      """,
                                    index
                                );
                              }
                          ),
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }

  Widget historyItem(String title, String type, String date, String decription, int index){
    return Container(
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
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
                  date,
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
              type,
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
              decription,
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
