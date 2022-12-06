import 'package:flutter/material.dart';
import '../../constant/assetImages.dart';
import '../../constant/strings.dart';
import '../../themes/colors.dart';
import '../generic_widgets/generic_input_widget.dart';
import '../generic_widgets/generic_numeric_input_widget.dart';
import '../generic_widgets/loading_widget.dart';



class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final controllerCedula = TextEditingController();
  final controllerEmail = TextEditingController();
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetImages.loginBackground),
                        fit: BoxFit.fill
                    )
                ),
              ),
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                Strings.loginTitle,
                                style: Theme.of(context).textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                Strings.recoverPasswordTitle,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold,color: darkGrey),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          bottom: 20,
                          top: 20
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GenericInput(controller: controllerEmail,backgroudColor: Colors.white,shadowColor: Colors.grey,title:Strings.emailText),
                          ),
                          const Divider(color: Colors.white,height: 25,),
                          Expanded(
                              flex: 1,
                              child:GenericNumberInputWidget(controller: controllerCedula,backgroudColor: Colors.white,shadowColor: Colors.grey,title: Strings.cedulaText)
                          ),
                          Expanded(
                              flex: 1,
                              child:Container()
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 25,
                                right: 25,
                                bottom: 14
                            ),
                            child: ElevatedButton(
                                style: Theme.of(context).elevatedButtonTheme.style,
                                onPressed: (){
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 25,
                                right: 25,
                                bottom: 14
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: mainOrange,width: 1.5)
                              ),
                              child: ElevatedButton(
                                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                                  onPressed: (){Navigator.pop(context);},
                                  child: Center(
                                    child: Text(
                                      Strings.returnButtonText,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainOrange,fontSize: 18,fontWeight: FontWeight.bold),
                                    ),
                                  )
                              ),
                            )
                          ),
                        ),

                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 30
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  Strings.copyRightText,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16,color: lightGrey.withOpacity(0.6)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                child: loading
                    ? LoadingWidget()
                    : Container(),
              ),
            ],
          ),
        )
    );
  }
}
