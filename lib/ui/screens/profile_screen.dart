import 'package:flutter/material.dart';
import 'package:itus_manager/provider/itus_response_provider.dart';
import 'package:itus_manager/themes/colors.dart';
import 'package:itus_manager/ui/generic_widgets/generic_numeric_input_widget.dart';
import 'package:provider/provider.dart';

import '../../constant/strings.dart';
import '../generic_widgets/generic_input_widget.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late final controllerName;
  late final controllerApellido1;
  late final controllerApellido2;
  late final controllerDocumento;
  late final controllerEmail;

  @override
  void initState() {
    controllerName = TextEditingController(text: context.read<ItusResponseProvider>().itusResponse!.itusUser.name);
    controllerApellido1  = TextEditingController(text: context.read<ItusResponseProvider>().itusResponse!.itusUser.apellido1);
    controllerApellido2 = TextEditingController(text: context.read<ItusResponseProvider>().itusResponse!.itusUser.apellido2);
    controllerDocumento = TextEditingController(text: context.read<ItusResponseProvider>().itusResponse!.itusUser.documento);
    controllerEmail = TextEditingController(text: context.read<ItusResponseProvider>().itusResponse!.itusUser.email);
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child:  Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            color: lightGrey.withOpacity(0.1),
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.9),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Text(
                                    Strings.nameTitle,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 2,
                              child: GenericInput(controller: controllerName,backgroudColor: Colors.white,shadowColor: Colors.grey,title:Strings.nameTitle),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Text(
                                    Strings.apellido1Title,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 2,
                              child: GenericInput(controller: controllerApellido1,backgroudColor: Colors.white,shadowColor: Colors.grey,title:Strings.apellido1Title),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Text(
                                    Strings.apellido2Title,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 2,
                              child: GenericInput(controller: controllerApellido2,backgroudColor: Colors.white,shadowColor: Colors.grey,title:Strings.apellido2Title),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Text(
                                    Strings.documentoTitle,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 2,
                              child: GenericNumberInputWidget(controller: controllerDocumento,backgroudColor: Colors.white,shadowColor: Colors.grey,title:Strings.documentoTitle),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Text(
                                    Strings.emailTitle,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 2,
                              child: GenericInput(controller: controllerEmail,backgroudColor: Colors.white,shadowColor: Colors.grey,title:Strings.emailTitle),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 50,
                          right: 50,
                          bottom: 90
                        ),
                        child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style,
                            onPressed: (){},
                            child: Center(
                              child: Text(
                                Strings.saveTitle,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}
