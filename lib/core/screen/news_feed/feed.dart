import 'package:flutter/material.dart';
import 'package:smartnote/core/screen/profile/profile_post.dart';
import 'package:smartnote/core/screen/profile/proifle.dart';
import 'package:smartnote/utils/theme/theme.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 150,
          width: 100,
          child: Image.asset("assets/image/smartnote.jpeg"),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.map)),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined))
        ],
      ),
      body:     DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Column(
          children: [

            TabBar(
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: CustomColors.primary),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: CustomColors.primary,
                              width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("All"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: CustomColors.primary, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Posts"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: CustomColors.primary,
                              width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Jobs"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: CustomColors.primary,
                              width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Scervices"),
                      ),
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(
                children: [
                  ProfilePostTab(), 
                  ProfilePostTab(),
                  ProfilePostTab(),
                  ProfilePostTab(),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }
}
