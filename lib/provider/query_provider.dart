import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itus_manager/model/Itus_guion.dart';
import 'package:itus_manager/model/QueryUser.dart';
import 'package:logger/logger.dart';
import '../constant/strings.dart';
import '../model/familyGroupMember.dart';

class QueryProvider with ChangeNotifier{

  List<QueryUser> currentQueryUsers=[];

  late QueryUser currentQueryUser;

  queryByDocument(String docType, String document)async{
    if(docType.isEmpty || document.isEmpty){
      throw Exception(Strings.queryFail);
    }
    Map data = {
      'datos_busqueda': '{"name":"","cellphone":"","document":"$document","tipodoc":"$docType"}'
    };

    Logger().i("QUERY-PROVIDER: DATA: ${data}");
    http.Response response= await http.post(
      Uri.parse("https://dev.itus.com.co:4430/api/visor/person"),
      body: data
    );
    if(response.statusCode==200){
      Logger().i("QUERY-PROVIDER: Response_body: ${response.body}");
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      Logger().i("QUERY-PROVIDER: SUCCESS DATA: ${responseBody["success"]["person"].length}");
      List<QueryUser> queryUsers=[];
      for(var element in responseBody["success"]["person"]){
        Logger().i("QUERY-PROVIDER: SUCCESS DATA ELEMENT: ${element}, ${element.runtimeType}");
        queryUsers.add(QueryUser.fromJson(element));
      }
      currentQueryUsers=queryUsers;
      notifyListeners();
      return currentQueryUsers.first;
    }else{
      Logger().i("QUERY-PROVIDER: Response: ${response.body}");
      throw Exception(Strings.queryFail);
    }
  }



  queryByName(String name)async{
     if(name.isEmpty){
       throw Exception(Strings.queryFail);
     }
     Map data = {
       'datos_busqueda': '{"name":"$name","cellphone":"","document":"","tipodoc":""}'
     };

     Logger().i("QUERY-PROVIDER: DATA: ${data}");


     http.Response response= await http.post(
         Uri.parse("https://dev.itus.com.co:4430/api/visor/person"),
         body: data
     );

     if(response.statusCode==200){
       Logger().i("QUERY-PROVIDER: Response_body: ${response.body}");
       Map<String,dynamic> responseBody= jsonDecode(response.body);
       Logger().i("QUERY-PROVIDER: SUCCESS DATA: ${responseBody["success"]["person"].length}");
       List<QueryUser> queryUsers=[];
       for(var element in responseBody["success"]["person"]){
         Logger().i("QUERY-PROVIDER: SUCCESS DATA ELEMENT: ${element}, ${element.runtimeType}");
         queryUsers.add(QueryUser.fromJson(element));
       }
       currentQueryUsers=queryUsers;
       notifyListeners();
     }else{
       Logger().i("QUERY-PROVIDER: Response: ${response.body}");
       throw Exception(Strings.queryFail);
     }
   }

   clearQuery(){
    currentQueryUsers=[];
    notifyListeners();
   }


  updateCurrentQueryUser(String docType, String document)async{
    if(docType.isEmpty || document.isEmpty){
      throw Exception(Strings.queryFail);
    }
    Map data = {
      'datos_busqueda': '{"name":"","cellphone":"","document":"$document","tipodoc":"$docType"}'
    };

    Logger().i("UPDATE-USER-PROVIDER: DATA: ${data}");
    http.Response response= await http.post(
        Uri.parse("https://dev.itus.com.co:4430/api/visor/person"),
        body: data
    );
    if(response.statusCode==200){
      Logger().i("UPDATE-USER-PROVIDER: Response_body: ${response.body}");
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      Logger().i("UPDATE-USER-PROVIDER: SUCCESS DATA: ${responseBody["success"]["person"].length}");

      currentQueryUser=QueryUser.fromJson(responseBody["success"]["person"][0]);


      Logger().i("UPDATE-USER-PROVIDER: Remain info: ${responseBody["success"]["person_detail"]}, ${responseBody["success"]["person_detail"].runtimeType}");

      currentQueryUser.setRemainInfo(responseBody["success"]["person_detail"]);

      notifyListeners();

    }else{
      Logger().i("QUERY-PROVIDER: Response: ${response.body}");
      throw Exception(Strings.queryFail);
    }
  }


  Future<List<FamilyGroupMember>> queryUserFamilyGroup(String document, String documentType)async{
    List<FamilyGroupMember> members=[];

    Logger().i("FAMILY-GROUP-DATA: LISTENING");

    http.Response response= await http.get(
        Uri.parse("https://dev.itus.com.co:4430/api/visor/grup-fam/$document/$documentType")
    );

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);

      String dataKey= responseBody["success"][0].keys.first;

      Logger().i("FAMILY-GROUP-DATA: ${dataKey}");

      Logger().i("FAMILY-GROUP-DATA: ${responseBody["success"][0][dataKey]}");


      for(var element in responseBody["success"][0][dataKey]["BENEFICIARIO"]){
        Logger().i("QUERY-PROVIDER: SUCCESS DATA ELEMENT: ${element}");
        members.add(FamilyGroupMember(element["nombre"], element["categoria_afiliacion"], element["tipo_afiliacion"]+"\n(BENEFICIARIO)"));
      }

      for(var element in responseBody["success"][0][dataKey]["TRABAJADOR"]){
        Logger().i("QUERY-PROVIDER: SUCCESS DATA ELEMENT: ${element}");
        members.add(FamilyGroupMember(element["nombre"], element["categoria_afiliacion"], element["tipo_afiliacion"]+"\n(TRABAJADOR)"));
      }
    }
    print(members.length);
    return members;
  }


  Future<List<String>> queryMissingUpdateData(String document, String documentType)async{

    List<String> missingData=[];


    Logger().i("FAMILY-GROUP-DATA: LISTENING");

    http.Response response= await http.get(
        Uri.parse("https://dev.itus.com.co:4430/api/alerta-valor/$document/$documentType")
    );

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      for(var element in responseBody["data"]){
        missingData.add(element["tipo_pendiente"]);
      }
    }

    return missingData;
  }



  Future<List<ItusGuion>> queryGuionesDireccionamiento(String document, String documentType, String cycle)async{

    List<ItusGuion> guiones=[];
    Logger().i("FAMILY-GROUP-DATA: LISTENING");

    http.Response response= await http.get(
        Uri.parse("https://dev.itus.com.co:4430/api/guion-valor/$document/$documentType")
    );
    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      String valor_cliente = responseBody["data"][0]["valor_cliente"].toString().toUpperCase();
      guiones = await _queryGuionesCicleXUser(cycle, valor_cliente);
      Logger().i("GUIONES-DATA: $guiones");
      Logger().i("GUIONES-DATA: ${guiones.length}");
    }
    return guiones;
  }




  Future<List<ItusGuion>> _queryGuionesCicleXUser(String cycle, String userSegment)async{

    List<ItusGuion> guionesXCicle= [];

    Logger().i("FAMILY-GROUP-DATA: LISTENING");

    http.Response response= await http.get(
        Uri.parse("https://dev.itus.com.co:4430/api/guion/$cycle")
    );

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      for(var element in responseBody["data"]){
        if(element["valor_cliente"]==userSegment){
          guionesXCicle.add(ItusGuion.fromJson(element));
        }
      }
    }
    return guionesXCicle;
  }



}
