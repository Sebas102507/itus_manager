import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itus_manager/model/CRM.dart';
import 'package:itus_manager/model/Inboud.dart';
import 'package:itus_manager/model/Itus_guion.dart';
import 'package:itus_manager/model/Outbound.dart';
import 'package:itus_manager/model/QueryUser.dart';
import 'package:logger/logger.dart';
import '../constant/strings.dart';
import '../model/ItusDocument.dart';
import '../model/familyGroupMember.dart';

class QueryService{

  /////////////////******ENDPOINTS******************/////////////
  final String DOCUMENTS_QUERY ="http://commonweb.itus.com.co:8088/microv1/api/all_active_doc_types";
  final String PERSON_QUERY ="https://dev.itus.com.co:4430/api/visor/person";
  final String FAMILY_GROUP_QUERY ="https://dev.itus.com.co:4430/api/visor/grup-fam";
  final String MISSING_DATA_QUERY ="https://dev.itus.com.co:4430/api/alerta-valor";
  final String GUIONES_QUERY ="https://dev.itus.com.co:4430/api/guion-valor";
  final String GUIONES_CYCLE_X_USER_QUERY ="https://dev.itus.com.co:4430/api/guion";
  final String OUTBOUND_QUERY ="https://dev.itus.com.co:4431/api/visor/out-boundv1";
  final String INBOUND_QUERY ="https://dev.itus.com.co:4431/api/visor/trx-inboundv1";
  final String CRM_QUERY ="https://dev.itus.com.co:4431/api/visor/crm-v1";

  /////////////////************************//////////////////////


  Future<List<ItusDocument>> queryAllDocuments()async{
    List<ItusDocument> documents=[];
    http.Response response= await http.get(Uri.parse(DOCUMENTS_QUERY));
    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      Logger().i("AUTH-PROVIDER: Response_body: ${response.body}");
      Logger().i("AUTH-PROVIDER: Response_token: ${responseBody["doctypes"]}");
      for(var element in responseBody["doctypes"]){
        documents.add(ItusDocument.fromJson(element));
      }
      return documents;
    }else{
      throw Exception(Strings.invalidLoginCredentials);
    }
  }


  Future<List<QueryUser>> queryByDocument(String docType, String document)async{
    if(docType.isEmpty || document.isEmpty){
      throw Exception(Strings.queryFail);
    }
    Map data = {
      'datos_busqueda': '{"name":"","cellphone":"","document":"$document","tipodoc":"$docType"}'
    };

    Logger().i("QUERY-PROVIDER: DATA: ${data}");
    http.Response response= await http.post(
        Uri.parse(PERSON_QUERY),
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
      return queryUsers;
    }else{
      Logger().i("QUERY-PROVIDER: Response: ${response.body}");
      throw Exception(Strings.queryFail);
    }
  }



  Future<List<QueryUser>> queryByName(String name)async{
    if(name.isEmpty){
      throw Exception(Strings.queryFail);
    }
    Map data = {
      'datos_busqueda': '{"name":"$name","cellphone":"","document":"","tipodoc":""}'
    };

    Logger().i("QUERY-PROVIDER: DATA: ${data}");

    http.Response response= await http.post(
        Uri.parse(PERSON_QUERY),
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
      return queryUsers;
    }else{
      Logger().i("QUERY-PROVIDER: Response: ${response.body}");
      throw Exception(Strings.queryFail);
    }
  }


  Future<QueryUser> queryCurrentUserFullInfo(String docType, String document)async{
    QueryUser queryUser;
    if(docType.isEmpty || document.isEmpty){
      throw Exception(Strings.queryFail);
    }
    Map data = {
      'datos_busqueda': '{"name":"","cellphone":"","document":"$document","tipodoc":"$docType"}'
    };

    Logger().i("UPDATE-USER-PROVIDER: DATA: ${data}");
    http.Response response= await http.post(
        Uri.parse(PERSON_QUERY),
        body: data
    );
    if(response.statusCode==200){
      Logger().i("UPDATE-USER-PROVIDER: Response_body: ${response.body}");
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      Logger().i("UPDATE-USER-PROVIDER: SUCCESS DATA: ${responseBody["success"]["person"].length}");

      queryUser=QueryUser.fromJson(responseBody["success"]["person"][0]);


      Logger().i("UPDATE-USER-PROVIDER: Remain info: ${responseBody["success"]["person_detail"]}, ${responseBody["success"]["person_detail"].runtimeType}");

      queryUser.setRemainInfo(responseBody["success"]["person_detail"]);

      return queryUser;

    }else{
      Logger().i("QUERY-PROVIDER: Response: ${response.body}");
      throw Exception(Strings.queryFail);
    }
  }



  Future<List<FamilyGroupMember>> queryUserFamilyGroup(String document, String documentType)async{
    List<FamilyGroupMember> members=[];

    Logger().i("FAMILY-GROUP-DATA: LISTENING");

    http.Response response= await http.get(
      Uri.parse("$FAMILY_GROUP_QUERY/$document/$documentType"),
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

    return members;
  }


  Future<List<String>> queryMissingUpdateData(String document, String documentType)async{
    List<String> missingData=[];

    Logger().i("FAMILY-GROUP-DATA: LISTENING");

    http.Response response= await http.get(
        Uri.parse("$MISSING_DATA_QUERY/$document/$documentType")
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
        Uri.parse("$GUIONES_QUERY/$document/$documentType")
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
        Uri.parse("$GUIONES_CYCLE_X_USER_QUERY/$cycle")
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


  Future<List<Outbound>> queryUserOutbound(String document, DateTime initial_date, DateTime final_date)async{
    List<Outbound> outbounds= [];

    Map data = {
      "identificacion": document,
      "initial_date": "${initial_date.year}-${initial_date.month}-${initial_date.day}",
      "final_date": "${final_date.year}-${final_date.month}-${final_date.day}"
    };

    Logger().i("QUERY-PROVIDER: DATA: ${data}");

    http.Response response= await http.post(
        Uri.parse(OUTBOUND_QUERY),
        body: data
    );

    Logger().i("RESPONSE- DATA: ${response}");

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      for(var element in responseBody["success"]){
        outbounds.add(Outbound.fromJson(element));
      }
    }
    return outbounds;
  }



  Future<List<Inbound>> queryUserInbound(String document, DateTime initial_date, DateTime final_date)async{
    List<Inbound> inbounds= [];
    Map data = {
      "identificacion": document,
      "initial_date": "${initial_date.year}-${initial_date.month}-${initial_date.day}",
      "final_date": "${final_date.year}-${final_date.month}-${final_date.day}"
    };

    Logger().i("QUERY-PROVIDER: DATA: ${data}");

    http.Response response= await http.post(
        Uri.parse(INBOUND_QUERY),
        body: data
    );

    Logger().i("RESPONSE- DATA: $response");

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      for(var element in responseBody["success"]){
        inbounds.add(Inbound.fromJson(element));
      }
    }
    return inbounds;
  }

  Future<List<CRM>> queryUserCRM(String document, DateTime initial_date, DateTime final_date)async{
    List<CRM> crms= [];
    Map data = {
      "identificacion": document,
      "initial_date": "${initial_date.year}-${initial_date.month}-${initial_date.day}",
      "final_date": "${final_date.year}-${final_date.month}-${final_date.day}"
    };
    Logger().i("QUERY-PROVIDER: DATA: ${data}");
    http.Response response= await http.post(
        Uri.parse(CRM_QUERY),
        body: data
    );
    Logger().i("RESPONSE- DATA: $response");
    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      for(var element in responseBody["success"]){
        crms.add(CRM.fromJson(element));
      }
    }
    return crms;
  }



}