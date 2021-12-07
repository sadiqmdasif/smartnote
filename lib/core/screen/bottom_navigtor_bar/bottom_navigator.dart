import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:smartnote/core/component/floating_bottons.dart';
import 'package:smartnote/core/component/video_picker.dart';
import 'package:smartnote/core/screen/message/message.dart';
import 'package:smartnote/core/screen/news_feed/feed.dart';
import 'package:smartnote/core/screen/profile/proifle.dart';
import 'package:smartnote/core/screen/search/search.dart';
import 'package:smartnote/utils/theme/theme.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  bool _isShowDial = false;
  static final List<Widget> _children = <Widget>[
    FeedPage(),
    SearchPage(),
    MessagePage(),
    Profile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     // floatingActionButton:_getFloatingActionButton(),
     floatingActionButton: _selectedIndex==0? FloatingActionButton(
        onPressed: () { 
        //  _getFloatingActionButton();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title:"title")));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add,size: 35,),
        elevation: 5.0,
      ):null,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: const Color(0xff999999),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.wifi,
                size: 25,
              )
          ),

          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.search, size: 25),

          ),

          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.messenger, size: 25),

          ),

          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.person, size: 25),

          ),
        ],

        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        selectedItemColor: CustomColors.primary,
        enableFeedback: true,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
      ),
      body: _children[_selectedIndex],
    );
  }
    Widget _getFloatingActionButton() {
    return SpeedDialMenuButton(
      mainFABPosX: 160,
      mainFABPosY: 10,
      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial,
      //manually open or close menu
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        this._isShowDial = isShow;
      },
      //general init
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
          mini: false,
          child: Icon(Icons.add,size: 35,),
          onPressed: () {},

          closeMenuChild: Icon(Icons.close),
          closeMenuForegroundColor: Colors.white,
          closeMenuBackgroundColor: Colors.red),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.volume_off),
          onPressed: () {
            //if need to close menu after click
            _isShowDial = false;
            setState(() {});
          },
          backgroundColor: Colors.pink,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.volume_down),
          onPressed: () {
            //if need to toggle menu after click
            _isShowDial = !_isShowDial;
            setState(() {});
          },
          backgroundColor: Colors.orange,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.volume_up),
          onPressed: () {
            //if no need to change the menu status
          },
          backgroundColor: Colors.deepPurple,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }

}
