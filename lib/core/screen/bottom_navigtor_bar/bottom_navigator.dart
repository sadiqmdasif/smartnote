import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      floatingActionButton:_selectedIndex==0? FloatingActionButton(
        onPressed: () { },
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
}
