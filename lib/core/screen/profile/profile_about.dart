import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smartnote/utils/theme/theme.dart';

class ProfileAboutTab extends StatefulWidget {
  const ProfileAboutTab({Key? key}) : super(key: key);

  @override
  _ProfileAboutTabState createState() => _ProfileAboutTabState();
}

class _ProfileAboutTabState extends State<ProfileAboutTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "VIEW",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                    Text(
                      "10",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade500),
                    ),
                    Text(
                      "View",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "17k RATINGS",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                    Text(
                      "4.7",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade500),
                    ),
                    RatingBar.builder(
                      initialRating: 4,
                      itemSize: 14,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding:
                          EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
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
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                    Text(
                      "10",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade500),
                    ),
                    Text(
                      "View",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
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
            padding: const EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text("About"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text("""Software engineer with 10 years of experience in

materials innovation, maintenance, production and

design. Strong attention to detail with considerable

leadership abilities."""),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("work"),
                    Icon(Icons.work),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, bottom: 8),
                child: Text("Prime tech"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Divider(
                    thickness: 1, height: 1, color: Colors.grey.shade400),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, bottom: 8),
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
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Educations"),
                    Icon(Icons.cast_for_education),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, bottom: 8),
                child: Text("AIub"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Divider(
                    thickness: 1, height: 1, color: Colors.grey.shade400),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, bottom: 8),
                child: Text("Aiub"),
              ),
            ],
          ),
        ],
      ),
    );
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
