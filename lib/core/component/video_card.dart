import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartnote/utils/theme/theme.dart';

import 'custom_image.dart';

class CustomPostVideoCard extends StatelessWidget {
  CustomPostVideoCard({
    required this.VideoUrl,
    required this.LogoImageUrl,
    this.BodyImageHeight = 200,
    this.BodyImageWidth = 900,
    this.LogoImageHeight = 70,
    this.LogoImageWidth = 70,
    this.compnayTitle='',
    this.heading='',
    this.time='',
    this.onTap,
    this.isSelected = false,
    required this.child,
    this.onLongPress,
    this.play=false,
  });

  final String VideoUrl;
  final String LogoImageUrl;
  final double BodyImageHeight;
  final double BodyImageWidth;
  final double LogoImageHeight;
  final double LogoImageWidth;
  final String? compnayTitle;
  final String? heading;
  final String? time;
  final void Function()? onTap;
  final bool isSelected;
  final Widget child;
  final void Function()? onLongPress;
  late final bool play;

  @override
  void didUpdateWidget(CustomPostVideoCard oldWidget) {
    if (oldWidget.play != play) {
      if (play) {
        play=true;
      } else {
        play=play;
      }
    }
  }

  @override
  void dispose() {
    play=false;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10),),),
          child: Column(
            children: [
             ClipRRect(
               borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(10),
                   topRight: Radius.circular(10)),
               child: BetterPlayer.network(
                 VideoUrl,
                 betterPlayerConfiguration: BetterPlayerConfiguration(
                   aspectRatio: 10/9,
                   fit: BoxFit.fill,
                   autoPlay: false,
                   autoDispose: true,
                   fullScreenByDefault: false,
                   autoDetectFullscreenDeviceOrientation: true,
                 ),
               ),
             ),
              SizedBox(
                height: CustomSpacing.small,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius:  BorderRadius.all(Radius.circular(15),),
                          child: Container(
                            height: LogoImageHeight,
                            width: LogoImageWidth,
                            decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(50)),
                            child: Image.network(
                              LogoImageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: CustomSpacing.medium,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            compnayTitle!,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            heading!,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            time!,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Icon(Icons.comment),
                          Text(
                            "14",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: CustomSpacing.medium,
                      ),
                      Column(
                        children: [
                          Icon(Icons.favorite),
                          Text(
                            "180",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: CustomSpacing.small,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: CustomSpacing.xSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
