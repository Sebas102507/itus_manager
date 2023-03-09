import 'package:flutter/material.dart';
import '../model/ItusMainResponse/ItusUserResponse.dart';


class ItusResponseProvider with ChangeNotifier{

  late ItusUserResponse? itusResponse;

  update(ItusUserResponse response){
    itusResponse=response;
    notifyListeners();
  }

  delete(){
    itusResponse =null;
    notifyListeners();
  }

}