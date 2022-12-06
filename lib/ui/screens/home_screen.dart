import 'package:flutter/material.dart';
import 'package:itus_manager/constant/routes.dart';
import 'package:itus_manager/ui/screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../../constant/assetImages.dart';
import '../../constant/strings.dart';
import '../../provider/itus_response_provider.dart';
import '../../provider/query_provider.dart';
import '../../themes/colors.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controllerCedula = TextEditingController();
  final controllerEmail = TextEditingController();
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: const BoxDecoration(
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.loginTitle,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AssetImages.targetIcon),
                            )
                        ),
                      ),
                    ),
                  ],
                )
              ),
              ListTile(
                title: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 25,
                      color: mainOrange,
                    ),
                    Text(
                      Strings.profileTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainOrange,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.profileScreen);
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Icon(
                      Icons.exit_to_app,
                      size: 25,
                      color: lightGrey,
                    ),
                    Text(
                      Strings.signOutTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightGrey,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  Provider.of<ItusResponseProvider>(context, listen: false).delete();
                  Navigator.of(context)
                      .pushAndRemoveUntil(
                    MaterialPageRoute(builder: (builder) => const LoginScreen()),
                        (route) => false,
                  );
                },
              ),
            ],
          ),
        ),

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
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.all(45),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetImages.targetIcon),
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        Strings.loginTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
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
                                          onPressed: (){
                                            Provider.of<QueryProvider>(context, listen: false).clearQuery();
                                            Navigator.pushNamed(context, Routes.queryScreen);
                                          },
                                          child: Center(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  size: 25,
                                                  color: mainOrange,
                                                ),
                                                Text(
                                                  Strings.userTitle,
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainOrange,fontSize: 18,fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          )
                                      ),
                                    )
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
                                          onPressed: (){

                                            },
                                          child: Center(
                                            child:  Row(
                                              children: [
                                                const Icon(
                                                  Icons.business_sharp,
                                                  size: 25,
                                                  color: mainOrange,
                                                ),
                                                Text(
                                                  Strings.companyTitle,
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainOrange,fontSize: 18,fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          )
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
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
                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
}
