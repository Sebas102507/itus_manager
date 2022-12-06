import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itus_manager/provider/itus_response_provider.dart';
import 'package:itus_manager/provider/query_provider.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => QueryProvider()),
          ChangeNotifierProvider(create: (context) => ItusResponseProvider()),
        ],
        child: const App(),
      ),
  );
}
