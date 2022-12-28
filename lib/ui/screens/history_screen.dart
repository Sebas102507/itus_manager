import 'package:flutter/material.dart';
import 'package:itus_manager/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../constant/strings.dart';
import '../../provider/itus_response_provider.dart';
import '../../provider/query_provider.dart';
import '../generic_widgets/crmItem.dart';
import '../generic_widgets/inboundItem.dart';
import '../generic_widgets/outboundItem.dart';

class HistoryScreen extends StatefulWidget {

  String userType;

  HistoryScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  String dropdownvalue = 'Outbound';
  List<String> historyOptions=["Outbound","Inbound","CRM"];
  DateTime initDate = DateTime(2022,01,01);
  DateTime lastDate = DateTime(2022,01,10);
  bool nonQuery=true;
  late String selectedValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
            widget.userType=="Persona"?Strings.historyTitle:Strings.businessHistoryTitle,
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
                                flex: 2,
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
                               const VerticalDivider(),
                               Expanded(
                                flex: 2,
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: lightGrey)
                                  ),
                                  child: InkWell(
                                    onTap: ()=> _selectDate(context, true),
                                    child: Center(
                                      child: Text(
                                        "${initDate.year}/${initDate.month}/${initDate.day}",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: lightGrey,fontSize: 12),
                                      ),
                                    )
                                  ),
                                )
                              ),
                              const Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: mainOrange,
                                    size: 22,
                                  )
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: lightGrey)
                                    ),
                                    child: InkWell(
                                        onTap: ()=> _selectDate(context, false),
                                        child: Center(
                                          child: Text(
                                            "${lastDate.year}/${lastDate.month}/${lastDate.day}",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(color: lightGrey,fontSize: 12),
                                          ),
                                        )
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 12,
                            ),
                            color: mainOrange,
                            child: InkWell(
                                onTap: ()async{
                                  if(dropdownvalue=="Outbound"){

                                    await query.queryUserOutbound(query.currentQueryUser.document, initDate, lastDate);

                                  }else if(dropdownvalue=="Inbound"){

                                    await query.queryUserInbound(query.currentQueryUser.document, initDate, lastDate);

                                  }else{

                                    await query.queryUserCRM(query.currentQueryUser.document, initDate, lastDate);

                                  }
                                  setState(() {
                                    selectedValue=dropdownvalue;
                                    nonQuery=false;
                                  });

                                },
                                child: const Center(
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                )
                            ),
                          )
                        ),
                        const Divider(
                          color: mainGreen,
                          thickness: 5,
                        ),
                        Expanded(
                          flex: 12,
                          child: listQuery(query)
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


  Future<void> _selectDate(BuildContext context, bool firstDate) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: firstDate? initDate: lastDate,
      firstDate: firstDate? DateTime(1980): initDate,
      lastDate: firstDate? lastDate: DateTime.now(),
      builder:  (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: mainOrange,
              onSurface: mainOrange,
            ),
          ),
          child: child!,
        );
      },
    );
    if (d != null) {
      setState(() {
        if(firstDate){
          initDate=d;
        }else{
          lastDate=d;
        }
      });
    }
  }


  Widget listQuery(queryProvider){
    if(nonQuery){
      return Center(
        child: Text(
          "Realice una consulta",
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black,fontSize: 12),
          textAlign: TextAlign.justify,
        ),
      );
    }

    if(selectedValue=="Outbound"){
      return queryProvider.outbounds.isEmpty?
      Center(
        child: Text(
          "No hay datos disponibles",
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black,fontSize: 12),
          textAlign: TextAlign.justify,
        ),
      )
          :
      ListView.builder(
          itemCount: queryProvider.outbounds.length,
          itemBuilder: (BuildContext context, int index) {
            return OutBoundItem(
                queryProvider.outbounds[index].fuente,
                queryProvider.outbounds[index].medio,
                queryProvider.outbounds[index].fecha_envio,
                queryProvider.outbounds[index].resumen,
                queryProvider.outbounds[index].mensaje,
                Provider.of<ItusResponseProvider>(context, listen: false).itusResponse!.token,
                index,
            );
          }
      );
    }else if(selectedValue=="Inbound"){
      return queryProvider.inbounds.isEmpty?
      Center(
        child: Text(
          "No hay datos disponibles",
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black,fontSize: 12),
          textAlign: TextAlign.justify,
        ),
      )
          :
      ListView.builder(
          itemCount: queryProvider.inbounds.length,
          itemBuilder: (BuildContext context, int index) {
            return InBoundItem(
                queryProvider.inbounds[index].linea,
                queryProvider.inbounds[index].medio,
                queryProvider.inbounds[index].fecha_envio,
                queryProvider.inbounds[index].resumen,
                index,
            );
          }
      );
    }else{
      return queryProvider.crms.isEmpty?
      Center(
        child: Text(
          "No hay datos disponibles",
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black,fontSize: 12),
          textAlign: TextAlign.justify,
        ),
      )
          :
      ListView.builder(
          itemCount: queryProvider.crms.length,
          itemBuilder: (BuildContext context, int index) {
            return CrmItem(
                queryProvider.crms[index].ciclo_negocio,
                queryProvider.crms[index].medio_respuesta,
                queryProvider.crms[index].fecha_envio,
              queryProvider.crms[index].descripcion_caso ?? queryProvider.crms[index].resumen,
                index,
            );
          }
      );
    }
  }
}
