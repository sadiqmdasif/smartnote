import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                                color: CustomColors.lightGreen,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16, top: 8, bottom: 8),
                                  child: Text(
                                    "Online",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Text("244 friends",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: CustomColors.primary))
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
                              Tab(
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
                              Tab(
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
                            ]),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1,
                        color: Colors.white,
                        child: TabBarView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "VIEW",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                          Text(
                                            "10",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey.shade500),
                                          ),
                                          Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "17k RATINGS",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                          Text(
                                            "4.7",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey.shade500),
                                          ),
                                          RatingBar.builder(
                                            initialRating: 4,
                                            itemSize: 14,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.0, vertical: 2),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              size: 10,
                                              color: CustomColors.primary,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                          Text(
                                            "10",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey.shade500),
                                          ),
                                          Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Video_card_widegt(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 10),
                                  child: Text("About"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 10),
                                  child: Text("About gtext"),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("work"),
                                          Icon(Icons.work),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, bottom: 8),
                                      child: Text("Prime tech"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Divider(
                                          thickness: 1,
                                          height: 1,
                                          color: Colors.grey.shade400),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, bottom: 8),
                                      child: Text("Prime tech"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Educations"),
                                          Icon(Icons.cast_for_education),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, bottom: 8),
                                      child: Text("AIub"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Divider(
                                          thickness: 1,
                                          height: 1,
                                          color: Colors.grey.shade400),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, bottom: 8),
                                      child: Text("Aiub"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text("tab2")
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ])),
        ));
  }

  Widget Video_card_widegt() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * .5,
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8, top: 8),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width * .7,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/image/videoimage.png",
                        ),
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
