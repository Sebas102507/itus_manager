import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:itus_manager/constant/routes.dart';
import 'package:itus_manager/model/QueryUser.dart';
import 'package:itus_manager/services/query_service.dart';
import 'package:itus_manager/ui/generic_widgets/generic_input_widget.dart';
import 'package:itus_manager/ui/generic_widgets/generic_numeric_input_widget.dart';
import 'package:itus_manager/ui/generic_widgets/queryChooserButton.dart';
import 'package:itus_manager/ui/generic_widgets/searchButton.dart';
import 'package:provider/provider.dart';
import '../../constant/strings.dart';
import '../../model/ItusDocument.dart';
import '../../provider/query_provider.dart';
import '../../themes/colors.dart';
import '../generic_widgets/loading_widget.dart';

class QueryScreen extends StatefulWidget {

  bool isPerson;

  QueryScreen(this.isPerson, {super.key});

  @override
  State<QueryScreen> createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {

  bool isDocumentSelected = true;
  final documentNumberController = TextEditingController();
  final userNameController = TextEditingController();
  final QueryService queryService= QueryService();
  late HashMap<String, int> documents;
  bool loading=false;
  List<QueryUser> queryUsers=[];
  int documentTypeSelected =1;
  ItusDocument _selectedValue = ItusDocument.init(1, "Cédula de ciudadanía", "CC");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            widget.isPerson?Strings.userTitle:Strings.companyTitle,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
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
                              child: QueryChooserButton(isDocument: true,isSelected:isDocumentSelected ,onPressed: (){
                                setState(() {
                                  isDocumentSelected = true;
                                  userNameController.clear();
                                });
                              },),
                            ),
                            const VerticalDivider(),
                            Expanded(
                              flex: 1,
                              child: QueryChooserButton(isDocument: false,isSelected:!isDocumentSelected ,onPressed: (){
                                setState(() {
                                  isDocumentSelected = false;
                                  documentNumberController.clear();
                                });
                              },),
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



  Widget searchWidget() {
    if(isDocumentSelected){
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
                                future: queryService.queryAllDocuments(),
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                  if(!snapshot.hasData){
                                    return LoadingWidget();
                                  } else if(snapshot.hasError){
                                    return const Center(
                                      child: Text("Hubo un error."),
                                    );
                                  }else{

                                    return DropdownButton<ItusDocument>(
                                      isExpanded: true,
                                      value: _selectedValue,
                                      onChanged: (ItusDocument? newValue) {
                                        setState(() {
                                          _selectedValue = newValue!;
                                          documentTypeSelected= _selectedValue.id_document;
                                        });
                                      },
                                      items: snapshot.data.map<DropdownMenuItem<ItusDocument>>((ItusDocument value) {
                                        return DropdownMenuItem<ItusDocument>(
                                          value: value,
                                          child:  Text(
                                            value.description,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }).toList(),
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
                          child: searchButtonCall()
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
                        widget.isPerson?Strings.userNameTitle:Strings.businessNameTitle,
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
                      child: GenericInput(
                          controller: userNameController,
                          backgroudColor: Colors.white,
                          shadowColor: Colors.grey,
                          title:widget.isPerson?Strings.userNameTitle:Strings.businessNameTitle),
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
                          child: searchButtonCall()
                      ),
                    ),
                    Expanded(
                      flex: 4,
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


  Widget searchButtonCall(){
    return SearchButton(
      onPressed: ()async{
        setState(() {loading=true;});
        try{
          if(isDocumentSelected){
            await Provider.of<QueryProvider>(context, listen: false).updateQueryByDocument("$documentTypeSelected",documentNumberController.text);
          }else{
            await Provider.of<QueryProvider>(context, listen: false).updateQueryByName(userNameController.text);
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
    );
  }


  Widget queryItem(QueryUser queryUser){
    return InkWell(
      onTap: ()async{
        setState(() {loading=true;});
        await Provider.of<QueryProvider>(context, listen: false).updateCurrentUserQuery(queryUser.tipo_identificacion,queryUser.document);
        setState(() {loading=false;});
        if(widget.isPerson){
          Navigator.pushNamed(context, Routes.itusUserHomeScreen);
        }else{
          Navigator.pushNamed(context, Routes.itusBusinessHomeScreen);
        }
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
                        child: SizedBox(
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
