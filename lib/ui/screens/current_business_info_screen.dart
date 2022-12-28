import 'package:flutter/material.dart';
import 'package:itus_manager/model/Itus_guion.dart';
import 'package:itus_manager/model/familyGroupMember.dart';
import 'package:itus_manager/provider/itus_response_provider.dart';
import 'package:itus_manager/services/query_service.dart';
import 'package:itus_manager/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../constant/strings.dart';
import '../../provider/query_provider.dart';

class CurrentBusinessInfoScreen extends StatefulWidget {
  const CurrentBusinessInfoScreen({Key? key}) : super(key: key);

  @override
  State<CurrentBusinessInfoScreen> createState() => _CurrentBusinessInfoScreenState();
}

class _CurrentBusinessInfoScreenState extends State<CurrentBusinessInfoScreen> {

  String dropdownvalue = 'Alojamiento';
  final QueryService _queryService= QueryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Strings.businessInfoTitle,
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
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*1.9),
            child: Consumer<QueryProvider>(
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
                        flex: 6,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:  Text(Strings.dataTitle,
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
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.documentTypeTitle,query.currentQueryUser.txt_tipodoc),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.documentNumberTitle,query.currentQueryUser.document),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.emailTitle,query.currentQueryUser.email),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.phoneTitle,query.currentQueryUser.cellphone),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.ageTitle,query.currentQueryUser.edad),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.categoryTitle,query.currentQueryUser.categoria_afiliacion),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.subsidioMonetarioTitle,query.currentQueryUser.subsidio_monetario),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.subsidioViviendaTitle,query.currentQueryUser.subsidio_vivienda),
                              ),
                            ),
                            const Divider(),

                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child:  Text(
                                        "${Strings.datperTitle}:",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(color: Colors.black,fontSize: 14),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10
                                      ),
                                      decoration: BoxDecoration(
                                          color: (query.currentQueryUser.dapter=="SI")?mainOrange:Colors.white,
                                          border: Border.all(
                                            color: (query.currentQueryUser.dapter=="SI")?mainOrange:lightGrey.withOpacity(0.7),
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          Strings.datperValueTitle,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(color: (query.currentQueryUser.dapter=="SI")?Colors.white:lightGrey.withOpacity(0.7),fontSize: 14),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child:  Text(
                                        "${Strings.contactFormTitle}:",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(color: Colors.black,fontSize: 14),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10
                                      ),
                                      decoration: BoxDecoration(
                                          color: (query.currentQueryUser.allow_sms==1)?mainOrange:Colors.white,
                                          border: Border.all(
                                            color: (query.currentQueryUser.allow_sms==1)?mainOrange:lightGrey.withOpacity(0.7),
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Celular",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(color: (query.currentQueryUser.allow_sms==1)?Colors.white:lightGrey.withOpacity(0.7),fontSize: 14),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10
                                      ),
                                      decoration: BoxDecoration(
                                          color: (query.currentQueryUser.allow_email==1)?mainOrange:Colors.white,
                                          border: Border.all(
                                            color: (query.currentQueryUser.allow_email==1)?mainOrange:lightGrey.withOpacity(0.7),
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Correo",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(color: (query.currentQueryUser.allow_email==1)?Colors.white:lightGrey.withOpacity(0.7),fontSize: 14),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 15,
                          ),
                          color: lightGrey.withOpacity(0.1),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Text(Strings.remainDataTitle,
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
                              Expanded(
                                  flex: 3,
                                  child:  Consumer<QueryProvider>(
                                    builder: (context, query, child) {
                                      return FutureBuilder(
                                        future: _queryService.queryMissingUpdateData(
                                            query.currentQueryUser.document,
                                            query.currentQueryUser.tipo_identificacion),

                                        builder: (BuildContext context, AsyncSnapshot snapshot){
                                          if(!snapshot.hasData || snapshot.hasError || snapshot.data.length==0){
                                            return Align(
                                              alignment: Alignment.center,
                                              child:  Text(
                                                "No hay informacion para la consulta",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(color: Colors.black,fontSize: 15),
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            );
                                          }else{
                                            return GridView.builder(
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,mainAxisSpacing: 15,childAspectRatio: 4),
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Container(
                                                    padding: const EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                    ),
                                                    height: 10,
                                                    decoration:  BoxDecoration(
                                                        border: Border.all(color: lightGrey),
                                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                                    ),
                                                    child:  Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        snapshot.data[index],
                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(color: Colors.black,fontSize: 12),
                                                        textAlign: TextAlign.center,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 5,
                                                      ),
                                                    )
                                                );
                                              },
                                            );
                                          }
                                        },
                                      );
                                    },
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: grupoFamiliarWidget(),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: guionesDireccionamientoWidget(),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        )
    );
  }


  Widget dataWidget(String title, String value){
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child:  Text(
              "$title:",
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.black,fontSize: 14),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.white,
            child: Align(
              alignment: Alignment.centerRight,
              child:  Text(
                value,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: lightGrey.withOpacity(0.7),fontSize: 14),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        )
      ],
    );
  }


  Widget subsidioWidget(){
    return Container(
      margin: const EdgeInsets.only(
          top: 10,
          bottom:10
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child:  Text(Strings.subsidioTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black,fontSize: 18),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child:Container(
                color: Colors.blue,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: mainGreen,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child:  Text(
                            "Tipo",
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white,fontSize: 15),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: mainGreen,
                        child: Container(
                          color: mainGreen,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text(
                              "Monto",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white,fontSize: 15),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
          Expanded(
              flex: 5,
              child:ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return subsidioItem("Monetario", 100000000000000);
                  }
              )
          ),
        ],
      ),
    );
  }


  Widget grupoFamiliarWidget(){
    return Container(
      margin: const EdgeInsets.only(
          top: 10,
          bottom:10
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child:  Text(Strings.grupoFamiliarTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black,fontSize: 18),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child:Container(
                color: Colors.blue,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: mainGreen,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child:  Text(
                            "Tipo afiliación",
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white,fontSize: 14),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: mainGreen,
                        child: Container(
                          color: mainGreen,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text(
                              "Nombre",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white,fontSize: 14),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: mainGreen,
                        child: Container(
                          color: mainGreen,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text(
                              "Categoria",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white,fontSize: 14),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),


          Expanded(
              flex: 5,
              child: Consumer<QueryProvider>(
                builder: (context, query, child) {
                  return FutureBuilder(
                    future: _queryService.queryUserFamilyGroup(
                        query.currentQueryUser.document,
                        query.currentQueryUser.tipo_identificacion),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(!snapshot.hasData || snapshot.hasError || snapshot.data.length==0){
                        return Align(
                          alignment: Alignment.center,
                          child:  Text(
                            "No hay informacion para la consulta",
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.black,fontSize: 15),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }else{
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return  Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: SizedBox(
                                  height: 100,
                                  child: grupoFamiliarItem(snapshot.data[index] as FamilyGroupMember),
                                ),
                              );
                            }
                        );
                      }
                    },
                  );

                },
              )
          )
        ],
      ),
    );
  }


  Widget guionesDireccionamientoWidget(){
    return Container(
      margin: const EdgeInsets.only(
          top: 10,
          bottom:10
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child:  Text(Strings.guionesDireccionamientoTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black,fontSize: 18),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child:  Text(Strings.cicloNegocioTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),


          Expanded(
              flex: 1,
              child:Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: lightGrey.withOpacity(0.3),width: 1.5),
                  color: Colors.white,
                ),
                child:  DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownvalue,
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
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              )
          ),
          Expanded(
              flex: 3,
              child:Container(
                color: lightGrey.withOpacity(0.1),
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.only(
                    top: 10
                ),
                child: Consumer<QueryProvider>(
                  builder: (context, query, child) {
                    return FutureBuilder(
                      future: _queryService.queryGuionesDireccionamiento(
                          query.currentQueryUser.document,
                          query.currentQueryUser.tipo_identificacion,
                          dropdownvalue
                      ),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        if(!snapshot.hasData || snapshot.hasError || snapshot.data.length==0){
                          return Align(
                            alignment: Alignment.center,
                            child:  Text(
                              "No hay informacion para la consulta",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.black,fontSize: 15),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }else{
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return  Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: guionItem(snapshot.data[index] as ItusGuion),
                                );
                              }
                          );
                        }
                      },
                    );

                  },
                )
              )
          ),
        ],
      ),
    );
  }


  Widget grupoFamiliarItem(FamilyGroupMember member){
    return Container(
      width: double.infinity,
      height: 50,
      color: lightGrey.withOpacity(0.1),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 8
                ),
                child: Align(
                  alignment: Alignment.center,
                  child:  Text(
                    member.tipo_afiliacion,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black,fontSize: 12),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
              )
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerLeft,
              child:  Text(
                member.nombre,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black,fontSize: 12),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child:  Text(
                member.categoria_afiliacion,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black,fontSize: 12),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget subsidioItem(String tipo, int monto){
    return Container(
      width: double.infinity,
      height: 50,
      color: lightGrey.withOpacity(0.1),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child:  Text(
                tipo,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black,fontSize: 15),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child:  Text(
                "\$${monto.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black,fontSize: 15),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget guionItem(ItusGuion guion){

    return  SizedBox(
      width: double.infinity,
      height: 150,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child:  Text(
                Strings.segmentoTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child:  Text(
                guion.valor_cliente,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: lightGrey,fontSize: 12),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.topLeft,
              child:  Text(
                guion.guion,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black,fontSize: 15),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
              ),
            ),
          ),
        ],
      ),
    );

  }

}
