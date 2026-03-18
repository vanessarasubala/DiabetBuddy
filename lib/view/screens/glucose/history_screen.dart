import 'package:flutter/material.dart';
import 'package:gluecose_monitor/data/model/gluecose_model.dart';
import 'package:gluecose_monitor/provider/gluecose_provider.dart';
import 'package:gluecose_monitor/utill/color_resources.dart';
import 'package:gluecose_monitor/utill/strings.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:gluecose_monitor/view/base/primary_button.dart';
import 'package:gluecose_monitor/view/screens/glucose/update_glucose_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HistoryScreen extends StatelessWidget {
  final String date;
  const HistoryScreen({@required this.date});

  @override
  Widget build(BuildContext context) {
    List<GluecoseModel> _listHistory = [];
    Provider.of<GluecoseProvider>(context, listen: false)
        .getHistory(date: date);

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
                'assets/icon/back.png',
                width: 25,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          title: Text(
            'History',
            textAlign: TextAlign.center,
            style: poppinsBold.copyWith(
              fontSize: 13.sp,
              color: ColorResources.COLOR_BLACK,
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer<GluecoseProvider>(
          builder: (context, gluecoseProvider, child) {
            _listHistory = gluecoseProvider.listHistory;
            if (gluecoseProvider.isLoading)
              context.loaderOverlay.show();
            else
              context.loaderOverlay.hide();

            return (_listHistory != null)
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(4.h, 1.h, 4.h, 3.h),
                    child: ListView.separated(
                      itemCount: gluecoseProvider.listHistory.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(height: 1.5.h);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${getFormattedDate(DateTime.parse(gluecoseProvider.listHistory[index].checkingDate))} - ${gluecoseProvider.listHistory[index].checkingTime}',
                                      style: poppinsBold.copyWith(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    Text(
                                      '${gluecoseProvider.listHistory[index].checkingType} - ${gluecoseProvider.listHistory[index].gluecoseResult} mg/dl',
                                      style: poppinsRegular.copyWith(
                                        fontSize: 11.sp,
                                        color: Color(0xFF7B6F72),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 2.h),
                              Expanded(
                                child: PrimaryButton(
                                  label: 'Edit',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateGlucoseScreen(
                                          gluecoseModel: gluecoseProvider
                                              .listHistory[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    padding: EdgeInsets.fromLTRB(4.h, 1.h, 4.h, 3.h),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 120,
                                  color: Color(0xFF9DCEFF),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'There is nothing data to shown',
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: Color(0xFFADA4A5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
