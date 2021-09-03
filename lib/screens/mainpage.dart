import 'package:driverapp_project/brand_colors.dart';
import 'package:driverapp_project/tabs/earningstab.dart';
import 'package:driverapp_project/tabs/hometab.dart';
import 'package:driverapp_project/tabs/profiletab.dart';
import 'package:driverapp_project/tabs/ratingstab.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  TabController tabController;
  int selecetedIndex = 0;

  void onItemClicked(int index){
    setState(() {
      selecetedIndex = index;
      tabController.index = selecetedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    //TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(

      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          HomeTab(),
          EarningsTab(),
          RatingsTab(),
          ProfileTab(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            title: Text('Earnings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Ratings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
          ),
        ],
        currentIndex: selecetedIndex,
        unselectedItemColor: BrandColors.colorIcon,
        selectedItemColor: BrandColors.colorOrange,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: onItemClicked,
      ),
    );
  }
}

