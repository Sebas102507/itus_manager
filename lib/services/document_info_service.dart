import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../constant/strings.dart';

class DocumentInfoService{


  Future<HashMap<String, int>> getAllDocuments()async{
    http.Response response= await http.get(Uri.parse("http://commonweb.itus.com.co:8088/microv1/api/all_active_doc_types"));
    if(response.statusCode==200){
      Map<String,dynamic> responseBody= jsonDecode(response.body);
      Logger().i("AUTH-PROVIDER: Response_body: ${response.body}");
      Logger().i("AUTH-PROVIDER: Response_token: ${responseBody["doctypes"]}");
      HashMap<String, int> documents = HashMap<String, int>();
      for(var element in responseBody["doctypes"]){
        documents.putIfAbsent(element["alias"], () =>element["id_document"]);
      }
      return documents;
    }else{
      throw Exception(Strings.invalidLoginCredentials);
    }
  }



}