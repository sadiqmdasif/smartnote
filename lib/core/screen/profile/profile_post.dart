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
    return Column(
      children: [
        Video_card_widget(),
      ],
    );
  }

  Widget Video_card_widget() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * .75,
        color: Colors.white,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, int index) {
            return CustomPostCard(
              BodyImageUrl: "assets/image/videoimage.png",
              LogoImageUrl: "assets/image/videoimage.png",
              compnayTitle: "Hireing game developer",
              heading: "Heading",
              time: "10 pm 10/11/2021",
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
