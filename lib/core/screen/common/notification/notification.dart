import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notification",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total : 10", style: TextStyle(color: Colors.black)),
                Text("Unread : 1", style: TextStyle(color: Colors.black))
              ],
            ),
            Container(
              height: 600,
              child: ListView.builder(
                itemBuilder: (context, int index) {
                  return Card(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              radius: 40,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/image/profile_photo.png",
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Prime tech ltd has viewed your application.",
                                style: TextStyle(color: Colors.black)),
                          )
                        ],
                      ),
                      Text("15/11/2021 5:55 PM",
                          style: TextStyle(color: Colors.black))
                    ],
                  ));
                },
                itemCount: 6,
              ),
            )
          ],
        ));
  }
}
