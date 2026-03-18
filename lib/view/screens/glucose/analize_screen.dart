import 'package:flutter/material.dart';
import 'package:gluecose_monitor/provider/analyze_provider.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timelines/timelines.dart';

class AnalizeScreen extends StatelessWidget {
  final int gluecoseId;
  const AnalizeScreen({@required this.gluecoseId});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> reason = [
      {
        "id": 1,
        "title": "Spread Your Arms",
        "deskripsi":
            "To make the gestures feel more relaxed, stretch your arms as you start this movement. No bending of hands.",
      },
      {
        "id": 2,
        "title": "Rest at The Toe",
        "deskripsi":
            "The basis of this movement is jumping. Now, what needs to be considered is that you have to use the tips of your feet",
      },
      {
        "id": 3,
        "title": "Adjust Foot Movement",
        "deskripsi":
            "Jumping Jack is not just an ordinary jump. But, you also have to pay close attention to leg movements.",
      },
      {
        "id": 4,
        "title": "Clapping Both Hands",
        "deskripsi":
            "This cannot be taken lightly. You see, without realizing it, the clapping of your hands helps you to keep your rhythm while doing the Jumping Jack",
      },
    ];
    Provider.of<AnalyzeProvider>(context, listen: false)
        .getAnalyze(gluecoseId: gluecoseId);
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: EdgeInsets.only(left: 4.h, top: 2.h, bottom: 2.h),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/icon/close.png',
                width: 25,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          title: SizedBox(),
          centerTitle: true,
        ),
        body: Consumer<AnalyzeProvider>(
          builder: (context, analyzeProvider, child) {
            if (analyzeProvider.isLoading)
              context.loaderOverlay.show();
            else
              context.loaderOverlay.hide();

            return (analyzeProvider.gluecoseStatus != '')
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(4.h, 1.h, 4.h, 3.h),
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/image/result.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Is this dangerous?',
                            style: poppinsBold.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            analyzeProvider.gluecoseStatus,
                            style: poppinsRegular.copyWith(
                              fontSize: 12.sp,
                              color:
                                  Color(int.parse(analyzeProvider.colorStatus)),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Reason',
                            style: poppinsBold.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          (analyzeProvider.reason.length > 1)
                              ? Container(
                                  child: FixedTimeline.tileBuilder(
                                    theme: TimelineThemeData(
                                      color: Color(0xFFEEA4CE),
                                      nodePosition: 0.1,
                                      indicatorTheme: IndicatorThemeData(
                                        size: 2.h,
                                      ),
                                      connectorTheme: ConnectorThemeData(
                                        thickness: 1,
                                      ),
                                    ),
                                    builder:
                                        TimelineTileBuilder.connectedFromStyle(
                                      itemCount: analyzeProvider.reason.length,
                                      firstConnectorStyle: null,
                                      lastConnectorStyle: null,
                                      // itemExtent: 100,
                                      indicatorStyleBuilder: (context, index) =>
                                          IndicatorStyle.outlined,
                                      connectorStyleBuilder: (context, index) =>
                                          ConnectorStyle.dashedLine,
                                      oppositeContentsBuilder:
                                          (context, index) => Padding(
                                        padding: EdgeInsets.only(right: 1.h),
                                        child: Text(
                                          '0${index + 1}',
                                          style: poppinsRegular.copyWith(
                                              fontSize: 13.sp,
                                              color: Color(0xFFEEA4CE)),
                                        ),
                                      ),
                                      contentsBuilder: (context, index) =>
                                          Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.h, bottom: 2.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              analyzeProvider.reason[index],
                                              style: poppinsRegular.copyWith(
                                                fontSize: 12.sp,
                                                color: Color(0xFF7B6F72),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : (analyzeProvider.reason.length == 1)
                                  ? Text(
                                      analyzeProvider.reason[0]['deskripsi'],
                                      style: poppinsRegular.copyWith(
                                        fontSize: 12.sp,
                                        color: Color(0xFF7B6F72),
                                      ),
                                    )
                                  : Container(),
                          SizedBox(height: 3.h),
                          Text(
                            'Guide',
                            style: poppinsBold.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          (analyzeProvider.guide.length > 1)
                              ? Container(
                                  child: FixedTimeline.tileBuilder(
                                    theme: TimelineThemeData(
                                      color: Color(0xFFEEA4CE),
                                      nodePosition: 0.1,
                                      indicatorTheme: IndicatorThemeData(
                                        size: 2.h,
                                      ),
                                      connectorTheme: ConnectorThemeData(
                                        thickness: 1,
                                      ),
                                    ),
                                    builder:
                                        TimelineTileBuilder.connectedFromStyle(
                                      itemCount: analyzeProvider.guide.length,
                                      firstConnectorStyle: null,
                                      lastConnectorStyle: null,
                                      // itemExtent: 100,
                                      indicatorStyleBuilder: (context, index) =>
                                          IndicatorStyle.outlined,
                                      connectorStyleBuilder: (context, index) =>
                                          ConnectorStyle.dashedLine,
                                      oppositeContentsBuilder:
                                          (context, index) => Padding(
                                        padding: EdgeInsets.only(right: 1.h),
                                        child: Text(
                                          '0${index + 1}',
                                          style: poppinsRegular.copyWith(
                                              fontSize: 13.sp,
                                              color: Color(0xFFEEA4CE)),
                                        ),
                                      ),
                                      contentsBuilder: (context, index) =>
                                          Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.h, bottom: 2.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              analyzeProvider.guide[index],
                                              style: poppinsRegular.copyWith(
                                                fontSize: 12.sp,
                                                color: Color(0xFF7B6F72),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : (analyzeProvider.guide.length == 1)
                                  ? Text(
                                      analyzeProvider.reason[0]['deskripsi'],
                                      style: poppinsRegular.copyWith(
                                        fontSize: 12.sp,
                                        color: Color(0xFF7B6F72),
                                      ),
                                    )
                                  : Container(),
                        ],
                      ),
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
