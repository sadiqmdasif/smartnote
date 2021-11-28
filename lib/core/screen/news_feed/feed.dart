

import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:provider/provider.dart';
import 'package:smartnote/core/component/action_clips.dart';
import 'package:smartnote/core/component/video_card.dart';
import 'package:smartnote/core/models/homepage.dart';
import 'package:smartnote/core/provider/viewState/homepage_view_state.dart';
import 'package:smartnote/core/screen/common/notification/notification.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final viewState = Provider.of<HomepgaeViewState>(context);
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 150,
          width: 100,
          child: Image.asset("assets/image/smartnote.jpeg"),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.map)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
              },
              icon: Icon(Icons.notifications_none_outlined))
        ],
      ),
      body:CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            expandedHeight: 80,
            flexibleSpace:ActionChipsRow<HomepageStatus>(
                items: [
                  ActionChipsRowItem(null, "All"),
                  ActionChipsRowItem(HomepageStatus.post, "Post"),
                  ActionChipsRowItem(HomepageStatus.jobs, "Jobs"),
                  ActionChipsRowItem(HomepageStatus.services, "Services"),
                ],
                onSelected: (HomepageStatus? status) =>
                    viewState.setStatusFilter(status),
                selected: viewState.statusFilter
            ),
          ),
          SliverFillRemaining(
            child:InViewNotifierList(
              scrollDirection: Axis.vertical,
              initialInViewIds: ['0'],
              isInViewPortCondition:
                  (double deltaTop, double deltaBottom, double viewPortDimension) {
                return deltaTop < (0.5 * viewPortDimension) &&
                    deltaBottom > (0.5 * viewPortDimension);
              },
              itemCount: 5,
              builder: (BuildContext context, int index) {
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final InViewState? inViewState =
                    InViewNotifierList.of(context);

                    inViewState!.addContext(context: context, id: '$index');

                    return AnimatedBuilder(
                      animation: inViewState,
                      builder: (context,child) {
                        return CustomPostVideoCard(
                          VideoUrl: "https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4",
                          LogoImageUrl: "https://www.pinclipart.com/picdir/big/7-79815_drawing-microsoft-office-cartoon-encapsulated-postscript-woman-man.png",
                          child: Container(),
                          compnayTitle: "Dhaka Video",
                          heading: "Hello! Dhaka",
                          time: "10:00 pm",

                        ) ;
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      )
    );
  }
}
