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
      floatingActionButton:_selectedIndex==0? _getFloatingActionButton():null,
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
      mainFABPosX: 163,
      mainFABPosY: 20,
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
          child: Icon(Icons.video_library),
          onPressed: () {
            _isShowDial = !_isShowDial;
           
     Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPickerPage(title:"gallary")));
          
          },
          backgroundColor: Colors.orange,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.video_camera_back),
          onPressed: () {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPickerPage(title:"camera")));
           
          },
          backgroundColor: Colors.deepPurple,
        ),
      ],
      isEnableAnimation: true,
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }

}
