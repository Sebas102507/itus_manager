import 'package:flutter/material.dart';
import 'package:itus_manager/services/query_service.dart';
import 'package:itus_manager/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../constant/strings.dart';
import '../../model/Queries/Business/QueryBusinessContact.dart';
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
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*1.4),
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
                            query.currentQueryBusiness.nombre_empresa,
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
                                child: dataWidget(Strings.documentTypeTitle,
                                    query.currentQueryBusiness.description_indentificacion, titleWidth: 1,valueWidth: 1),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.documentNumberTitle,
                                    query.currentQueryBusiness.identificacion,titleWidth: 4,valueWidth: 3),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.emailTitle,query.currentQueryBusiness.email),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.phoneTitle,query.currentQueryBusiness.celular),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.segmentoTitle,query.currentQueryBusiness.segmento),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.cantidadTrabajadoresTitle,
                                    query.currentQueryBusiness.cantidad_trabajadores.toString(), titleWidth: 6,valueWidth: 2),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.actividadEconomicaTitle,query.currentQueryBusiness.act_economica),
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
                                          color: (query.currentQueryBusiness.contacts.isNotEmpty && query.currentQueryBusiness.contacts.first.datper=="SI")?mainOrange:Colors.white,
                                          border: Border.all(
                                            color: (query.currentQueryBusiness.contacts.isNotEmpty && query.currentQueryBusiness.contacts.first.datper=="SI")?mainOrange:lightGrey.withOpacity(0.7),
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
                                              ?.copyWith(color: (query.currentQueryBusiness.contacts.isNotEmpty && query.currentQueryBusiness.contacts.first.datper=="SI")?Colors.white:lightGrey.withOpacity(0.7),fontSize: 14),
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
                              child: Container(
                                child: dataWidget(Strings.barrioTitle,query.currentQueryBusiness.barrio),
                              ),
                            ),
                            const Divider(),

                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.direccionTitle,query.currentQueryBusiness.direccion),
                              ),
                            ),
                            const Divider(),

                            Expanded(
                              flex: 1,
                              child: Container(
                                child: dataWidget(Strings.asesorPACTitle,query.currentQueryBusiness.asesor_pac??"NA"),
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
                                          color: (query.currentQueryBusiness.autorizacion_celular=="SI")?mainOrange:Colors.white,
                                          border: Border.all(
                                            color: (query.currentQueryBusiness.autorizacion_celular=="SI")?mainOrange:lightGrey.withOpacity(0.7),
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          Strings.phoneTitle,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(color: (query.currentQueryBusiness.autorizacion_celular=="SI")?Colors.white:lightGrey.withOpacity(0.7),fontSize: 14),
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
                                          color: (query.currentQueryBusiness.autorizacion_email=="SI")?mainOrange:Colors.white,
                                          border: Border.all(
                                            color: (query.currentQueryBusiness.autorizacion_email=="SI")?mainOrange:lightGrey.withOpacity(0.7),
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          Strings.emailTitle,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(color: (query.currentQueryBusiness.autorizacion_email=="SI")?Colors.white:lightGrey.withOpacity(0.7),fontSize: 14),
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
                                            query.currentQueryBusiness.identificacion,
                                            query.currentQueryBusiness.tipo_identificacion.toString()),

                                        builder: (BuildContext context, AsyncSnapshot snapshot){
                                          if(!snapshot.hasData || snapshot.hasError || snapshot.data.length==0){
                                            return Align(
                                              alignment: Alignment.center,
                                              child:  Text(
                                                Strings.queryFail,
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
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:  Text(Strings.grupoRelacionalTitle,
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

                            const Divider(
                              color: mainGreen,
                              thickness: 5,
                            ),

                            Expanded(
                              flex: 6,
                              child: ListView.builder(
                                  itemCount: query.currentQueryBusiness.contacts.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return contactItem(index, query.currentQueryBusiness.contacts.elementAt(index));
                                  }
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
    );
  }


  Widget dataWidget(String title, String value, {titleWidth=3, valueWidth=4}){
    return Row(
      children: [
        Expanded(
          flex: titleWidth,
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
          flex: valueWidth,
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



  Widget contactItem(int index, QueryBusinessContact queryBusinessContact){
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      color: (index%2==0)?lightGrey.withOpacity(0.1):Colors.white,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              queryBusinessContact.persona_contacto,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.black,fontSize: 16),
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.cargoTitle,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: mainGreen,fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    queryBusinessContact.cargo_contacto,
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
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.phoneTitle,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: mainGreen,fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    queryBusinessContact.celular_contacto,
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
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.emailTitle,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: mainGreen,fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    queryBusinessContact.email_contacto,
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
              ),
            ],
          )
        ],
      ),
    );
  }





}
