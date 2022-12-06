import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:itus_manager/constant/routes.dart';
import 'package:itus_manager/model/QueryUser.dart';
import 'package:itus_manager/services/document_info_service.dart';
import 'package:itus_manager/ui/generic_widgets/generic_input_widget.dart';
import 'package:itus_manager/ui/generic_widgets/generic_numeric_input_widget.dart';
import 'package:provider/provider.dart';

import '../../constant/strings.dart';
import '../../provider/query_provider.dart';
import '../../themes/colors.dart';
import '../generic_widgets/loading_widget.dart';



class QueryScreen extends StatefulWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  State<QueryScreen> createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {

  bool isDocument = true;

  var hello={1,2,3};
  var hello2=[1,2,3];

  final documentNumberController = TextEditingController();
  final userNameController = TextEditingController();
  final DocumentInfoService documentInfoService= DocumentInfoService();
  late HashMap<String, int> documents;
  bool loading=false;
  String dropdownvalue = 'CC';
  List<QueryUser> queryUsers=[];
  int documentTypeSelected =1;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Stack(
          children: [
            SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10,
                      right: 10
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  Strings.queryForTitle,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: documentButton(),
                              ),
                            ),
                            const VerticalDivider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: nameButton(),
                              ),
                            )
                          ],
                        ),
                      ),

                      Expanded(
                          flex: 7,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 25
                            ),
                            padding: const EdgeInsets.all(12),
                            color: lightGrey.withOpacity(0.1),
                            child: searchWidget(),
                          )
                      ),
                      const Divider(
                          color: mainGreen,height: 10
                      ),
                      Expanded(
                          flex: 11,
                          child: Consumer<QueryProvider>(
                            builder: (context, query, child) {
                              return query.currentQueryUsers.isNotEmpty?
                              ListView.builder(
                                  itemCount: query.currentQueryUsers.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return queryItem(query.currentQueryUsers.elementAt(index));
                                  }
                              )
                                  :
                              Container();
                            },
                          )
                      )
                    ],
                  ),
                )
            ),
            Positioned(
              child: loading
                  ? LoadingWidget()
                  : Container(),
            ),
          ],
        )
    );
  }


  Widget documentButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isDocument = true;
          userNameController.clear();
        });
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: (isDocument) ? mainOrange : Colors.white,
          side: BorderSide(
              color: (isDocument) ? mainOrange : lightGrey
          )
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          Strings.queryForDocument,
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: (isDocument) ? Colors.white : lightGrey, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  Widget nameButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isDocument = false;
          documentNumberController.clear();
        });
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: (!isDocument) ? mainOrange : Colors.white,
          side: BorderSide(
              color: (!isDocument) ? mainOrange : lightGrey
          )
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          Strings.queryForName,
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: (!isDocument) ? Colors.white : lightGrey,fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }



  Widget searchWidget() {
    if(isDocument){
      return Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:  Text(
                        Strings.documentTypeTitle,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),

                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: lightGrey.withOpacity(0.3),width: 1.5),
                          color: Colors.white,
                        ),
                        child:  FutureBuilder(
                          future: documentInfoService.getAllDocuments(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(!snapshot.hasData){
                              return LoadingWidget();
                            } else if(snapshot.hasError){
                              return const Center(
                                child: Text("Hubo un error."),
                              );
                            }else{
                              return  DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownvalue,
                                items: (snapshot.data as HashMap<String, int>).keys.map((String items) {
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
                                    documentTypeSelected=(snapshot.data as HashMap<String, int>)[newValue]!;
                                    print(documentTypeSelected);
                                  });
                                },
                              );
                            }
                          }
                        )
                      )
                    )
                )

              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:  Text(
                      Strings.documentNumberTitle,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10
                      ),
                      child: GenericNumberInputWidget(controller: documentNumberController,backgroudColor: Colors.white,shadowColor: Colors.grey,title:Strings.documentNumberTitle),
                    )
                )

              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                        child: searchButton()
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(),
                  )
                ],
              )
            ),
          )
        ],
      );
    }else{

      return Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:  Text(
                        Strings.userNameTitle,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10
                      ),
                      child: GenericInput(controller: userNameController,backgroudColor: Colors.white,shadowColor: Colors.grey,title:Strings.userNameTitle),
                    )
                )

              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                          child: searchButton()
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(),
                    )
                  ],
                )
            ),
          ),

          Expanded(
              flex: 2,
              child: Container()
          ),

        ],
      );
    }
  }



  Widget searchButton(){
    return ElevatedButton(
      onPressed: ()async{
        setState(() {loading=true;});
        try{
          if(isDocument){
             await Provider.of<QueryProvider>(context, listen: false).queryByDocument("$documentTypeSelected",documentNumberController.text);
          }else{
            await Provider.of<QueryProvider>(context, listen: false).queryByName(userNameController.text);
          }
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {loading=false;});
        }catch(e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().substring(11)),backgroundColor: Colors.red,));
          Provider.of<QueryProvider>(context, listen: false).clearQuery();
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {loading=false;});
        }
      },
      child:  Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(
                Strings.searchTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const Icon(Icons.search,color: Colors.white,size: 30)
            ],
          )
      ),
    );
  }


  Widget queryItem(QueryUser queryUser){
    return InkWell(
      onTap: ()async{
        setState(() {loading=true;});
        await Provider.of<QueryProvider>(context, listen: false).updateCurrentQueryUser(queryUser.tipo_identificacion,queryUser.document);
        Navigator.pushNamed(context, Routes.currentUserInfoScreen);
        setState(() {loading=false;});
      },
      child:  Container(
          color: lightGrey.withOpacity(0.1),
          margin: const EdgeInsets.only(
              top: 5
          ),
          height: 70,
          width: double.infinity,
          child: Row(
            children: [
              const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.person,
                    color: darkGrey,
                    size: 35,
                  )
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${queryUser.name} ${queryUser.lastname}",
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black, fontSize: 17,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${queryUser.txt_tipodoc} ${queryUser.document}",
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: mainGreen, fontSize: 17,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: darkGrey,
                    size: 35,
                  )
              ),
            ],
          )
      ),
    );
  }


}


