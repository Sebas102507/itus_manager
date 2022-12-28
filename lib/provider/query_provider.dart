import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itus_manager/model/CRM.dart';
import 'package:itus_manager/model/Inboud.dart';
import 'package:itus_manager/model/Itus_guion.dart';
import 'package:itus_manager/model/Outbound.dart';
import 'package:itus_manager/model/QueryUser.dart';
import 'package:itus_manager/services/query_service.dart';
import 'package:logger/logger.dart';
import '../constant/strings.dart';
import '../model/familyGroupMember.dart';

class QueryProvider with ChangeNotifier{

  /////////////////******ENDPOINTS******************/////////////

  final String PERSON_QUERY ="https://dev.itus.com.co:4430/api/visor/person";
  final String FAMILY_GROUP_QUERY ="https://dev.itus.com.co:4430/api/visor/grup-fam";
  final String MISSING_DATA_QUERY ="https://dev.itus.com.co:4430/api/alerta-valor";
  final String GUIONES_QUERY ="https://dev.itus.com.co:4430/api/guion-valor";
  final String GUIONES_CYCLE_X_USER_QUERY ="https://dev.itus.com.co:4430/api/guion";
  final String OUTBOUND_QUERY ="https://dev.itus.com.co:4431/api/visor/out-boundv1";
  final String INBOUND_QUERY ="https://dev.itus.com.co:4431/api/visor/trx-inboundv1";
  final String CRM_QUERY ="https://dev.itus.com.co:4431/api/visor/crm-v1";

  /////////////////************************//////////////////////

  final QueryService _queryService = QueryService();
  List<QueryUser> currentQueryUsers=[];
  late QueryUser currentQueryUser;
  List<Outbound> outbounds= [];
  List<Inbound> inbounds= [];
  List<CRM> crms= [];

  updateQueryByDocument(String docType, String document)async{
    currentQueryUsers= await _queryService.queryByDocument(docType, document);
    notifyListeners();
  }

  updateCurrentUserQuery(String docType, String document)async{
    currentQueryUser= await _queryService.queryCurrentUserFullInfo(docType, document);
    notifyListeners();
  }

  updateQueryByName(String name)async{
    currentQueryUsers= await _queryService.queryByName(name);
    notifyListeners();
 }


   clearQuery(){
    currentQueryUsers=[];
    notifyListeners();
   }


   queryUserOutbound(String document, DateTime initial_date, DateTime final_date)async{
    outbounds = await _queryService.queryUserOutbound(document, initial_date, final_date);
     notifyListeners();
  }



  queryUserInbound(String document, DateTime initial_date, DateTime final_date)async{
    inbounds =  await _queryService.queryUserInbound(document, initial_date, final_date);
    notifyListeners();
  }


  queryUserCRM(String document, DateTime initial_date, DateTime final_date)async{
    crms =  await _queryService.queryUserCRM(document, initial_date, final_date);
    notifyListeners();
  }



}
