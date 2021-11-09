import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartnote/utils/theme/theme.dart';

import 'custom_image.dart';

class CustomPostCard extends StatelessWidget {
   CustomPostCard({
    required this.BodyImageUrl,
    required this.LogoImageUrl,
    this.BodyImageHeight = 200,
    this.BodyImageWidth = 900,
    this.LogoImageHeight = 60,
    this.LogoImageWidth = 60,
    this.compnayTitle='',
    this.heading='',
    this.time='',
    this.onTap,
    this.isSelected = false,
    required this.child,
    this.onLongPress,
  });

  final String BodyImageUrl;
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: Container(
                      height: LogoImageHeight,
                      width: LogoImageWidth,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                      child: CustomImage.asset(
                        LogoImageUrl,
                        fit: BoxFit.cover,
                        emptyImageColor: CustomColors.imageBackground,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        compnayTitle!,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        heading!,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        time!,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
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
                ],
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                height: BodyImageHeight,
                width: BodyImageWidth,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: CustomImage.asset(
                  BodyImageUrl,
                  fit: BoxFit.cover,

               emptyImageColor: CustomColors.imageBackground,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
