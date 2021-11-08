import 'package:flutter/material.dart';
import 'package:smartnote/core/component/custom_post_card.dart';

class ProfilePostTab extends StatefulWidget {
  const ProfilePostTab({Key? key}) : super(key: key);

  @override
  _ProfilePostTabState createState() => _ProfilePostTabState();
}

class _ProfilePostTabState extends State<ProfilePostTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      child: Column(
        children: [
          Video_card_widget(),
        ],
      ),
    );
  }

  Widget Video_card_widget() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * .5,
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, int index) {
            return CustomPostCard(
              BodyImageUrl: "assets/image/videoimage.png",
              LogoImageUrl: "assets/image/videoimage.png",
              child: Container(
                height: 20,
                width: 40,
              ),
            );
          },
        ),
      ),
    );
  }
}
