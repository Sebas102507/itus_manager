import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itus_manager/model/Historico/CRM.dart';
import 'package:itus_manager/model/Historico/Inboud.dart';
import 'package:itus_manager/model/Queries/Business/QueryBusiness.dart';
import 'package:itus_manager/model/Guion/Itus_guion.dart';
import 'package:itus_manager/model/Historico/Outbound.dart';
import 'package:itus_manager/model/Queries/User/QueryUser.dart';
import 'package:itus_manager/model/ItusNotifications/itus_notification.dart';
import 'package:itus_manager/model/question/QueryQuestionData.dart';
import 'package:logger/logger.dart';
import '../constant/strings.dart';
import '../model/ItusDocument/ItusDocument.dart';
import '../model/ItusNotifications/ItusSentNotifications.dart';
import '../GroupMember/familyGroupMember.dart';

class QueryService{

  /////////////////******ENDPOINTS******************/////////////
  final String DOCUMENTS_QUERY ="http://commonweb.itus.com.co:8088/microv1/api/all_active_doc_types";
  final String PERSON_QUERY ="https://dev.itus.com.co:4430/api/visor/person";

  final String BUSINESS_QUERY_BY_DOCUMENT ="https://dev.itus.com.co:4430/api/visor-companies-show";
  final String CAMPAIN_QUERY_BY_DOCUMENT ="https://dev.itus.com.co:4430/api/campaigns-bussines-index";

  final String QUESTIONS_QUERY ="https://dev.itus.com.co:4430/api/find-suggested-questions";


  final String FAMILY_GROUP_QUERY ="https://dev.itus.com.co:4430/api/visor/grup-fam";
  final String MISSING_DATA_QUERY ="https://dev.itus.com.co:4430/api/alerta-valor";
  final String GUIONES_QUERY ="https://dev.itus.com.co:4430/api/guion-valor";
  final String GUIONES_CYCLE_X_USER_QUERY ="https://dev.itus.com.co:4430/api/guion";
  final String OUTBOUND_QUERY ="https://dev.itus.com.co:4431/api/visor/out-boundv1";
  final String INBOUND_QUERY ="https://dev.itus.com.co:4431/api/visor/trx-inboundv1";
  final String CRM_QUERY ="https://dev.itus.com.co:4431/api/visor/crm-v1";
  final String ALL_USER_NOTIF ="https://dev.itus.com.co:4430/api/notf";
  final String SENT_USER_NOTIF ="https://dev.itus.com.co:4431/api/visor";


  /////////////////************************//////////////////////


  Future<List<ItusDocument>> queryAllDocuments()async{
    List<ItusDocument> documents=[];
    http.Response response= await http.get(Uri.parse(DOCUMENTS_QUERY));
    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      for(var element in responseBody["doctypes"]){
        documents.add(ItusDocument.fromJson(element));
      }
      return documents;
    }else{

      Logger().i("ERROR: ${response.statusCode} ${response.body}");

      throw Exception(Strings.queryFail);
    }
  }


  Future<List<QueryUser>> queryByDocument(String docType, String document)async{
    if(docType.isEmpty || document.isEmpty) throw Exception(Strings.queryFail);

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
    if(name.isEmpty)throw Exception(Strings.queryFail);

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


  Future<List<QueryBusiness>> queryBusinessByDocument(String docType, String document,List<ItusDocument> allDocuments)async{

    List<QueryBusiness> itusBusiness=[];

    if(docType.isEmpty || document.isEmpty) throw Exception(Strings.queryFail);

    Map data = {
    "name":"",
    "document":document,
    "tipodoc":docType
    };

    Logger().i("QUERY-PROVIDER: DATA: $data");
    http.Response response= await http.post(
        Uri.parse(BUSINESS_QUERY_BY_DOCUMENT),
        body: data
    );
    if(response.statusCode==200){
      Logger().i("QUERY-PROVIDER: Response_body: ${response.body}");
      Map<String,dynamic> responseBody= jsonDecode(response.body);

      if(responseBody["success"]==null)throw Exception(Strings.queryFail);

      QueryBusiness queryBusiness=QueryBusiness.fromJson(responseBody["success"]);

      queryBusiness.description_indentificacion =  _getBussinessDocumentDescription(queryBusiness.tipo_identificacion, allDocuments);
      queryBusiness.alias_indentificacion =  _getBussinessDocumentAlias(queryBusiness.tipo_identificacion,allDocuments);

      itusBusiness.add(queryBusiness);
      return itusBusiness;

    }else{
      Logger().i("QUERY-PROVIDER: Response: ${response.body}");
      throw Exception(Strings.queryFail);
    }
  }


  Future<List<QueryBusiness>> queryBusinessByName(String name, List<ItusDocument> allDocuments)async{
    List<QueryBusiness> itusBusiness=[];

    if(name.isEmpty)throw Exception(Strings.queryFail);

    Map data = {
      "name":name,
      "document":"",
      "tipodoc":""
    };

    Logger().i("QUERY-PROVIDER: DATA: $data");
    http.Response response= await http.post(
        Uri.parse(BUSINESS_QUERY_BY_DOCUMENT),
        body: data
    );

    if(response.statusCode==200){
      Logger().i("QUERY-PROVIDER: Response_body: ${response.body}");
      Map<String,dynamic> responseBody= jsonDecode(response.body);

      if(responseBody["success"]==null)throw Exception(Strings.queryFail);

      for (var business in responseBody["success"]){
        QueryBusiness queryBusiness=QueryBusiness.fromJson(business);
        queryBusiness.description_indentificacion =  _getBussinessDocumentDescription(queryBusiness.tipo_identificacion,allDocuments);
        queryBusiness.alias_indentificacion =  _getBussinessDocumentAlias(queryBusiness.tipo_identificacion,allDocuments);
        itusBusiness.add(queryBusiness);
      }
      return itusBusiness;

    }else{
      Logger().i("QUERY-PROVIDER: Response: ${response.body}");
      throw Exception(Strings.queryFail);
    }
  }


  String _getBussinessDocumentDescription(int document,List<ItusDocument> allDocuments){
    return (allDocuments.firstWhere((element) => element.id_document==document)).description;
  }


  String _getBussinessDocumentAlias(int document,List<ItusDocument> allDocuments){
    return (allDocuments.firstWhere((element) => element.id_document==document)).alias;
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


  Future<List<String>> queryAllCampaigns()async{
    List<String> campains=[];

    http.Response response= await http.get(
        Uri.parse(CAMPAIN_QUERY_BY_DOCUMENT),
    );

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      for(var cam in responseBody["campaigns"]){
        campains.add(cam);
      }
    }
    return campains;

  }


  Future<List<String>> queryAllBusinessCyclesByCampaigns(String campain)async{
    List<String> cycles=[];

    http.Response response= await http.get(
      Uri.parse(CAMPAIN_QUERY_BY_DOCUMENT),
    );

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
        for(var cam in responseBody["businessByCampaign"][campain]){
          cycles.add(cam);
      }
    }
    return cycles;
  }


  Future<QueryQuestionData?> queryQuestionByCampaignBusinessCycle(String? campaign, String? businessCycle, String question)async{

    QueryQuestionData? queryQuestionData;

    String encodedQuestion= Uri.encodeComponent(question.replaceAll("?", "").replaceAll("¿", ""));

    Logger().i("ENCODED QUESTIONS: $encodedQuestion");

    Logger().i("URL: $QUESTIONS_QUERY/$encodedQuestion/$campaign/$businessCycle");

    http.Response response= await http.get(
      Uri.parse("$QUESTIONS_QUERY/$encodedQuestion/$campaign/$businessCycle"),
    );

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      queryQuestionData= QueryQuestionData.fromJson(responseBody);
    }
    return queryQuestionData;
  }


  Future<QueryQuestionData?> queryQuestionFromUrl(String url)async{

    QueryQuestionData? queryQuestionData;

    http.Response response= await http.get(
      Uri.parse(url),
    );

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      queryQuestionData= QueryQuestionData.fromJson(responseBody);
    }
    return queryQuestionData;
  }


  Future<List<ItusNotification>> getAllNotificationsData(String document, String docType)async {
    List<ItusNotification> allNotifications = await _queryAllUserNotifications(document, docType);
    List<ItusSentNotifications> sentNotifications = await _queryUserSentNotifications(document);
    List<ItusNotification> showNotifications =[];
    for (var element in allNotifications) {
      if(sentNotifications.where((element2) => element2.tipo==element.titulo_notificacion && element2.fecha!.day==element.fechain!.day  && element2.fecha!.month==element.fechain!.month && element2.fecha!.year==element.fechain!.year).isEmpty){
        showNotifications.add(element);
      }
    }
    return showNotifications;
  }

   _queryAllUserNotifications(String document, String docType)async{
     List<ItusNotification> allNotifications =[];
    http.Response response= await http.get(
      Uri.parse("$ALL_USER_NOTIF/$document/$docType"),
    );

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      for(var element in responseBody["success"]){
        String objectKey = element.keys.first;

       try{
         if (element[objectKey].containsKey("SMS") && element[objectKey]["SMS"].containsKey("master")) {
           allNotifications.add(ItusNotification.fromJson(element[objectKey]["SMS"]["master"]));

         } else if (element[objectKey].containsKey("EMAIL") && element[objectKey]["EMAIL"].containsKey("master")) {
           allNotifications.add(ItusNotification.fromJson(element[objectKey]["EMAIL"]["master"]));

         } else if (element[objectKey].containsKey("WHATSAPP") && element[objectKey]["WHATSAPP"].containsKey("master")) {
           allNotifications.add(ItusNotification.fromJson(element[objectKey]["WHATSAPP"]["master"]));
         }
       }catch(e){
         Logger().e("Error : $e, ${objectKey}");
       }

      }
    }
    return allNotifications;
  }



  _queryUserSentNotifications(String document)async{
    List<ItusSentNotifications> sentNotifications =[];
    http.Response response= await http.get(
      Uri.parse("$SENT_USER_NOTIF/$document/perfil"),
    );

    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      for(var element in responseBody["success"]["notificaciones"]){
        try{
          sentNotifications.add(ItusSentNotifications.fromJson(element));
        }catch(e){
          Logger().e("Error : $e, $element");
        }
      }
    }
    return sentNotifications;
  }




}