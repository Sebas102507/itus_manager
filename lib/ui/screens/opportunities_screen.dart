import 'package:flutter/material.dart';
import 'package:itus_manager/model/ItusNotifications/itus_notification.dart';
import 'package:itus_manager/provider/query_provider.dart';
import 'package:itus_manager/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../constant/strings.dart';
import '../generic_widgets/loading_widget.dart';

class OpportunitiesScreen extends StatefulWidget {
  bool isPerson;
  OpportunitiesScreen({Key? key, required this.isPerson}) : super(key: key);

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {

  final controller = TextEditingController();
  bool initNotifications = true;
  List<ItusNotification> selectedNotifications =[];
  bool loading=false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final queryService= Provider.of<QueryProvider>(context);
    if(initNotifications){
      queryService.setCurrenShowNotifications(queryService.currentQueryUser.document, queryService.currentQueryUser.tipo_identificacion);
      initNotifications=false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.isPerson?Strings.opportunitiesTitle:Strings.businessOpportunitiesTitle,
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
      body: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(
                  left: 12,
                  right: 12
              ),
              child: Consumer<QueryProvider>(
                builder: (context,query, child) {
                  if(query.currentShowNotifications==null){
                    return LoadingWidget();
                  }else if (query.currentShowNotifications!.isEmpty){
                    return Center(
                      child: Text(
                        Strings.nonNotificationsTitle,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black,fontSize: 16),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }else{
                    return CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: query.currentNotificationsGroups.length,
                                  (context, index) {
                                return notificationsDataBox(group: query.currentNotificationsGroups.elementAt(index), selectedNotifications: selectedNotifications);
                              }
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(
                              height: 300,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25,
                                        bottom: 10
                                    ),
                                    child:  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        Strings.comentariosTitle,
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
                                  Container(
                                    color: lightGrey.withOpacity(0.1),
                                    padding: const EdgeInsets.all(20),
                                    child:  TextField(
                                      textInputAction: TextInputAction.done,
                                      style:  Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.grey,fontSize: 16),
                                      maxLines: 4,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: Strings.writeComentarioTitle,
                                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 90,
                                    color: lightGrey.withOpacity(0.1),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        width: 120,
                                        height: 45,
                                        child: ElevatedButton(
                                            style: Theme.of(context).elevatedButtonTheme.style,
                                            onPressed: ()async{
                                              setState(() {loading=true;});
                                              await queryService.setCurrenShowNotifications(queryService.currentQueryUser.document, queryService.currentQueryUser.tipo_identificacion);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(Strings.finishSentNotificationsTitle),
                                                    backgroundColor: Colors.green,
                                                  )
                                              );
                                              setState(() {loading=false;});
                                            },
                                            child: Center(
                                              child: Text(
                                                Strings.sendButtonText,
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            )
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                        )
                      ],
                    );
                  }
                },
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
}


class notificationsDataBox extends StatefulWidget {
  String group;
  List<ItusNotification> selectedNotifications;
  notificationsDataBox({Key? key, required this.group, required this.selectedNotifications}) : super(key: key);

  @override
  State<notificationsDataBox> createState() => _notificationsDataBoxState();
}

class _notificationsDataBoxState extends State<notificationsDataBox> {
  late List<ItusNotification> groupNotifications=[];
  double height=65;
  bool close= true;
  bool initNotifications = true;
  bool check = true;
  late List<bool> isChecked;


  @override
  Widget build(BuildContext context) {
    final queryService= Provider.of<QueryProvider>(context);

    if(initNotifications){
      groupNotifications = queryService.currentShowNotifications!.where((element) => element.ciclo_negocio==widget.group).toList();
      initNotifications=false;
      isChecked = List<bool>.filled(groupNotifications.length, false);
    }


    return Padding(
      padding: const EdgeInsets.only(
        top: 25
      ),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              height: 50,
              width: double.infinity,
              color: lightGrey.withOpacity(0.1),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                        flex: 10,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.group,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.black,fontSize: 17),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                    ),

                    Expanded(
                        flex: 1,
                        child:  Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  close=!close;
                                });
                              },
                              child: Text(
                                close?"+":"-",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: mainOrange,fontSize: 40, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                        )
                    )
                  ],
                ),
              )
          ),

          close?
          Container()
              :
          Container(
            height: height* (groupNotifications.length).toDouble(),
            padding: const EdgeInsets.only(
                left: 10,
                right: 10
            ),
            width: double.infinity,
            color: lightGrey.withOpacity(0.2),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: groupNotifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                      height: height,
                      child: CheckboxListTile(
                        activeColor: mainOrange,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                groupNotifications.elementAt(index).titulo_notificacion!,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black, fontSize: 14),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${groupNotifications.elementAt(index).fechain!.day}/${groupNotifications.elementAt(index).fechain!.month}/${groupNotifications.elementAt(index).fechain!.year}",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.black, fontSize: 12),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        value: isChecked[index],
                        onChanged: (val) {
                          setState(() {
                              isChecked[index]= val!;
                              if(isChecked[index]){
                                widget.selectedNotifications.add(groupNotifications.elementAt(index));
                              }else{
                                widget.selectedNotifications.remove(groupNotifications.elementAt(index));
                              }
                            },
                          );
                        },
                      )
                  );
                }
            ),
          ),

        ],
      ),
    );
  }
}
