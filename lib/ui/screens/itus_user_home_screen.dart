import 'package:flutter/material.dart';
import 'package:itus_manager/themes/colors.dart';
import 'package:itus_manager/ui/screens/current_user_info_screen.dart';
import 'package:itus_manager/ui/screens/frecuent_questions_screen.dart';

import '../../constant/strings.dart';
import 'history_screen.dart';


class ItusUserHomeScreen extends StatefulWidget {
  const ItusUserHomeScreen({Key? key}) : super(key: key);

  @override
  State<ItusUserHomeScreen> createState() => _ItusUserHomeScreenState();
}

class _ItusUserHomeScreenState extends State<ItusUserHomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: selectedScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items:   <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.person, color: Colors.white,),
            label: Strings.informationNavBar,
            backgroundColor: mainOrange,
          ),
           BottomNavigationBarItem(
            icon: const Icon(Icons.history, color: Colors.white,),
            label: Strings.historyNavBar,
            backgroundColor: mainOrange
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.question_answer, color: Colors.white,),
              label: Strings.questionsNavBar,
              backgroundColor: mainOrange
          ),
           BottomNavigationBarItem(
            icon: const Icon(Icons.star, color: Colors.white,),
            label: Strings.oportunitiesNavBar,
            backgroundColor: mainOrange
          ),
        ],
        currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
        onTap: _onItemTapped
      )
    );
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  Widget selectedScreen(){
    if(_selectedIndex==0){
      return const CurrentUserInfoScreen();
    }else if(_selectedIndex==1){
      return HistoryScreen(isPerson: true);
    }else if(_selectedIndex==2){
      return FrecuentQuestionsScreen();
    }else{
      return Container(color: Colors.cyanAccent,);
    }
  }

}
