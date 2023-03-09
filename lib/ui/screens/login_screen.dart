import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itus_manager/constant/assetImages.dart';
import 'package:itus_manager/constant/routes.dart';
import 'package:itus_manager/provider/itus_response_provider.dart';
import 'package:itus_manager/services/ToastMessage.dart';
import 'package:itus_manager/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../constant/strings.dart';
import '../../model/ItusMainResponse/ItusUserResponse.dart';
import '../../provider/query_provider.dart';
import '../../services/auth_service.dart';
import '../generic_widgets/generic_input_widget.dart';
import '../generic_widgets/loading_widget.dart';
import '../generic_widgets/password_input.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();
  final AuthService authService = AuthService();
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
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          Strings.loginTitle,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                              child:PasswordInput(controllerEmail: controllerPassword,backgroudColor: Colors.white,shadowColor: Colors.grey,seePassword: true)
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
                                onPressed: ()async{
                                  try{
                                    setState(() {loading=true;});
                                    ItusUserResponse response = await authService.authLogin(controllerEmail.text,controllerPassword.text);
                                    Provider.of<ItusResponseProvider>(context, listen: false).update(response);
                                    await Provider.of<QueryProvider>(context, listen: false).initData();
                                    setState(() {loading=false; controllerEmail.clear(); controllerPassword.clear();});
                                    Navigator.pushNamed(context, Routes.homeScreen);
                                  }catch(e){
                                    setState(() {loading=false; controllerEmail.clear(); controllerPassword.clear();});
                                    ToastMessage.genericMessage(e.toString().substring(11));
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    Strings.loginText,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: RichText(
                              text: TextSpan(
                                  text: Strings.forgotPassword,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainOrange,fontSize: 18),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, Routes.recoverPasswordScreen);
                                    }),
                            ),
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


