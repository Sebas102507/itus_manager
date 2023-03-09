import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itus_manager/util/text_utils.dart';
import 'package:logger/logger.dart';
import '../constant/strings.dart';
import '../model/ItusMainResponse/ItusUser.dart';
import '../model/ItusMainResponse/ItusUserResponse.dart';

class AuthService{


    Future<ItusUserResponse> authLogin(String email, String password)async{
      if(email.isEmpty || !email.isEmail() || password.isEmpty){
        throw Exception(Strings.invalidLoginCredentials);
      }
      http.Response response= await http.post(Uri.parse("https://dev.itus.com.co:4430/api/visor/login?email=$email&password=$password"));
      if(response.statusCode==200){
        Map<String,dynamic> responseBody= jsonDecode(response.body);
        Logger().i("AUTH-PROVIDER: Response_body: ${response.body}");
        Logger().i("AUTH-PROVIDER: Response_token: ${responseBody["token"]}");
        Logger().i("AUTH-PROVIDER: Response_user: ${responseBody["user_detail"]}");

        return ItusUserResponse(responseBody["token"], ItusUser.fromJson(responseBody["user_detail"]));
      }else{
        throw Exception(Strings.invalidLoginCredentials);
      }
  }



}