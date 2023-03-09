import 'package:flutter/material.dart';
import 'package:itus_manager/model/Historico/CRM.dart';
import 'package:itus_manager/model/Historico/Inboud.dart';
import 'package:itus_manager/model/Queries/Business/QueryBusiness.dart';
import 'package:itus_manager/model/Queries/User/QueryUser.dart';
import 'package:itus_manager/model/ItusNotifications/itus_notification.dart';
import 'package:itus_manager/model/question/QueryQuestionData.dart';
import 'package:itus_manager/services/query_service.dart';
import '../model/Historico/Outbound.dart';
import '../model/ItusDocument/ItusDocument.dart';

class QueryProvider with ChangeNotifier{

  final QueryService _queryService = QueryService();

  List<ItusDocument> allDocuments=[];

  List<QueryUser> currentQueryUsers=[];
  late QueryUser currentQueryUser;

  List<QueryBusiness> currentQueryBusinesses=[];
  late QueryBusiness currentQueryBusiness;

  List<Outbound> outbounds= [];
  List<Inbound> inbounds= [];
  List<CRM> crms= [];

  List<String> campaigns=[];
  List<String> campaignsBusinessCycles=[];

  QueryQuestionData? currentQuestionsQuery;
  QueryQuestionData? fullQuestionsQuery;

  List<ItusNotification>? currentShowNotifications;
  List<String> currentNotificationsGroups=[];



  initData()async{
    updateAllDocuments();
    updateCampainsQuery();
  }

  updateAllDocuments()async{
    allDocuments= await _queryService.queryAllDocuments();
    notifyListeners();
  }


  updateQueryByDocument(String docType, String document)async{
    currentQueryUsers= await _queryService.queryByDocument(docType, document);
    notifyListeners();
  }

  updateBusinessQueryByDocument(String docType, String document)async{
    currentQueryBusinesses= await _queryService.queryBusinessByDocument(docType, document,allDocuments);
    notifyListeners();
  }


  updateQueryByName(String name)async{
    currentQueryUsers= await _queryService.queryByName(name);
    notifyListeners();
 }

  updateBusinessQueryByName(String name)async{
    currentQueryBusinesses= await _queryService.queryBusinessByName(name,allDocuments);
    notifyListeners();
  }


  updateCurrentUserQuery(String docType, String document)async{
    currentQueryUser= await _queryService.queryCurrentUserFullInfo(docType, document);
    notifyListeners();
  }


  updateCurrentBusinessQuery(String docType, String document)async{
    currentQueryBusiness= (await _queryService.queryBusinessByDocument(docType, document,allDocuments)).first;
    notifyListeners();
  }


   clearQuery(){
    currentQueryUsers=[];
    currentQueryBusinesses=[];
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

  setCurrenShowNotifications(String document, String docType)async{
    currentShowNotifications = await _queryService.getAllNotificationsData(document, docType);
    currentNotificationsGroups = currentShowNotifications!.map((n) => n.ciclo_negocio!).toSet().toList();
    notifyListeners();
  }


  clearCurrentNotifications(){
    currentShowNotifications=null;
    currentNotificationsGroups=[];
    notifyListeners();
  }



  updateCampainsQuery()async{
    campaigns= await _queryService.queryAllCampaigns();
    notifyListeners();
  }

  updateCampainsBusinessCycles(String campaign)async{
    campaignsBusinessCycles= await _queryService.queryAllBusinessCyclesByCampaigns(campaign);
    notifyListeners();
  }

  updateCurrentQuestionsQuery(String campaign, String businessCycle, String question)async{
    currentQuestionsQuery = await _queryService.queryQuestionByCampaignBusinessCycle(campaign, businessCycle, question);
    notifyListeners();
  }

  updateFullQuestionsQuery(String question)async{
    fullQuestionsQuery = await _queryService.queryQuestionByCampaignBusinessCycle(null, null, question);
    notifyListeners();
  }


  updateFullQuestionsQueryFromUrl(String url)async{
    fullQuestionsQuery = await _queryService.queryQuestionFromUrl(url);
    notifyListeners();
  }



  clearCurrentQuestionQuery(){
    currentQuestionsQuery = null;
    notifyListeners();
  }

  clearCurrentFullQuestionQuery(){
    fullQuestionsQuery = null;
  }


  clearBusinessCycles(){
    campaignsBusinessCycles=[];
  }


  clearAll(){
    clearCurrentFullQuestionQuery();
    clearBusinessCycles();
  }

}
