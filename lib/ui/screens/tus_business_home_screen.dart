import 'package:flutter/material.dart';
import 'package:itus_manager/themes/colors.dart';
import 'package:itus_manager/ui/screens/current_business_history_screen.dart';
import 'package:itus_manager/ui/screens/current_business_info_screen.dart';
import 'package:itus_manager/ui/screens/current_user_info_screen.dart';

import '../../constant/strings.dart';
import 'current_user_history_screen.dart';


class ItusBusinessHomeScreen extends StatefulWidget {
  const ItusBusinessHomeScreen({Key? key}) : super(key: key);

  @override
  State<ItusBusinessHomeScreen> createState() => _ItusBusinessHomeScreenState();
}

class _ItusBusinessHomeScreenState extends State<ItusBusinessHomeScreen> with SingleTickerProviderStateMixin {
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
          backgroundColor: mainOrange,
          unselectedItemColor: Colors.white,
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
      return const CurrentBusinessInfoScreen();
    }else if(_selectedIndex==1){
      return const CurrentBusinessHistoryScreen();
    }else{
      return Container(color: Colors.cyanAccent,);
    }
  }

}
