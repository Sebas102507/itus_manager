import 'package:flutter/material.dart';
import 'package:itus_manager/model/ItusUserResponse.dart';

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