import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtd/adMob/bannerAd.dart';
import 'package:gtd/models/inboxModel.dart';
import 'package:gtd/providers/inboxProvider.dart';
import 'package:gtd/routes/appRoutes.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:gtd/utils/constantToast.dart';
import 'package:provider/provider.dart';

import '../../providers/themeProvider.dart';
import '../widgets/textWidget.dart';

class NoIsItActionAble extends StatefulWidget {
  InboxModel holeData;
  int intIndex;
  NoIsItActionAble({Key? key, required this.holeData, required this.intIndex})
      : super(key: key);

  @override
  State<NoIsItActionAble> createState() => _NoIsItActionAbleState();
}

class _NoIsItActionAbleState extends State<NoIsItActionAble> {
  bool checkvalue = false;
  bool trash = false;
  bool someDayMaybe = false;
  bool reference = false;
  InboxProvider inboxProvider = InboxProvider();
  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(
      ad: AdmobHelper.getBannerAd()..load(),
    );
    context.watch<DarkThemeProvider>().getdarkTheme();
    return Consumer<DarkThemeProvider>(builder: (context, prov1, _) {
      return Scaffold(
        backgroundColor:
            prov1.darkTheme == false ? AppColors.appThemeColor : Colors.black,
        appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: prov1.darkTheme == false
                    ? AppColors.textDarkColor
                    : Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: text(
              context,
              'What is it ?',
              20.sp,
              boldText: FontWeight.w600,
              color: prov1.darkTheme == false
                  ? AppColors.textDarkColor
                  : Colors.white,
            )),
        body: Container(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          child: Column(
            children: [
              textSpanWidget(),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text(
                    context,
                    'No action.',
                    40.sp,
                    boldText: FontWeight.w600,
                    color: prov1.darkTheme == false
                        ? AppColors.textDarkColor
                        : Colors.white,
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textColor.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.question_mark,
                        color: AppColors.textColor,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      inboxProvider.updateTODOItem(
                        widget.intIndex,
                        InboxModel(
                          todoText: widget.holeData.todoText,
                          dateTime: widget.holeData.dateTime,
                          status: widget.holeData.status,
                          extendedate: widget.holeData.extendedate,
                          trashStatus: 'true',
                          somedayMaybeStatus: widget.holeData.trashStatus,
                          referenceStatus: widget.holeData.referenceStatus,
                        ),
                      );
                      ToastUtils.showCustomToast(
                        context,
                        "Todo Added in Trash",
                        Colors.green,
                      );
                      // AppRoutes.pop(context);
                    },
                    child: Container(
                      height: 105.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.trash,
                              color: AppColors.textDarkColor,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            text(
                              context,
                              'Trash',
                              12.sp,
                              boldText: FontWeight.w600,
                              color: AppColors.textDarkColor,
                              fontFamily: 'Hiragino Kaku Gothic ProN',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      inboxProvider.updateTODOItem(
                        widget.intIndex,
                        InboxModel(
                          todoText: widget.holeData.todoText,
                          dateTime: widget.holeData.dateTime,
                          status: widget.holeData.status,
                          extendedate: widget.holeData.extendedate,
                          trashStatus: widget.holeData.trashStatus,
                          somedayMaybeStatus: 'true',
                          referenceStatus: widget.holeData.referenceStatus,
                        ),
                      );
                      ToastUtils.showCustomToast(
                          context, "Todo Added in SomeDay/MayBe", Colors.green);
                      // AppRoutes.pop(context);
                    },
                    child: Container(
                      height: 105.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.fileLines,
                              color: AppColors.textDarkColor,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: text(
                                    context,
                                    'SomeDay Maybe',
                                    12.sp,
                                    boldText: FontWeight.w600,
                                    color: AppColors.textDarkColor,
                                    fontFamily: 'Hiragino Kaku Gothic ProN',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      inboxProvider.updateTODOItem(
                        widget.intIndex,
                        InboxModel(
                          todoText: widget.holeData.todoText,
                          dateTime: widget.holeData.dateTime,
                          status: widget.holeData.status,
                          extendedate: widget.holeData.extendedate,
                          trashStatus: widget.holeData.trashStatus,
                          somedayMaybeStatus:
                              widget.holeData.somedayMaybeStatus,
                          referenceStatus: 'true',
                        ),
                      );
                      ToastUtils.showCustomToast(
                          context, "Todo Added in Reference", Colors.green);
                      // AppRoutes.pop(context);
                    },
                    child: Container(
                      height: 105.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.newspaper,
                              color: AppColors.textDarkColor,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            text(
                              context,
                              'Reference',
                              12.sp,
                              boldText: FontWeight.w600,
                              color: AppColors.textDarkColor,
                              fontFamily: 'Hiragino Kaku Gothic ProN',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () {
                  AppRoutes.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    Container(
                      height: 80.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: AppColors.textDarkColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          text(
                            context,
                            'Back',
                            25.sp,
                            boldText: FontWeight.w600,
                            color: AppColors.textDarkColor,
                            fontFamily: 'Hiragino Kaku Gothic ProN',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.bottomCenter,
                child: adWidget,
              ),
            ],
          ),
        ),
      );
    });
  }

  textSpanWidget() {
    return Container(
      width: 399.w,
      // height: 174.h,
      padding: EdgeInsets.only(
        left: 25.h,
        right: 25.h,
        top: 15.h,
        bottom: 15.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
                text: widget.holeData.todoText,
                style: TextStyle(
                  fontFamily: 'Hiragino Kaku Gothic ProN',
                  color: AppColors.textDarkColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              text(context, widget.holeData.dateTime, 10.sp,
                  boldText: FontWeight.w600, fontFamily: "Hiragino Sans"),
            ],
          )
        ],
      ),
    );
  }
}
