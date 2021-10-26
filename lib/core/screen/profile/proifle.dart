import 'package:flutter/material.dart';
import 'package:smartnote/utils/theme/theme.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                Icon((Icons.settings)),
                Text(
                  "Settings",
                  style: TextStyle(color: Colors.black),
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Column(children: [
                Container(
                    height: 20,
                    width: 900,
                    color: Colors.grey.shade300,
                    child: Text(
                        "*Your profile 80% complete, Please update your pfoiile for posting job/service in settings.")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/image/profile_photo.png",
                          height: 100, width: 100, fit: BoxFit.cover),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sadiq md asif",
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          ),
                          Text(
                            "@sadiq",
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          Text(
                            "Software Engineer",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Colors.green.shade600,
                                child: Text("Online"),
                              ),
                              Text("244 friends")
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.grey.shade600,
                ),
                SizedBox(
                  height: 20,
                ),
                DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25.0,
                          right: 25,
                        ),
                        child: TabBar(
                            unselectedLabelColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: CustomColors.primary),
                            tabs: [
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: CustomColors.primary,
                                            width: 1)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("About"),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: CustomColors.primary,
                                            width: 1)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Post"),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        height: 700,
                        width: 1000,
                        color: Colors.white,
                        child: TabBarView(
                          children: [Text("tab !"), Text("tab2")],
                        ),
                      ),
                    ],
                  ),
                )
              ])),
        ));
  }
}
