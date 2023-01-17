import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtd/adMob/bannerAd.dart';
import 'package:gtd/all%20Screen/widgets/textWidget.dart';
import 'package:gtd/models/inboxModel.dart';
import 'package:gtd/providers/inboxProvider.dart';
import 'package:gtd/routes/appRoutes.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:gtd/utils/constantToast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../providers/themeProvider.dart';
import 'inboxScreen.dart';

class YesSpetificDate extends StatefulWidget {
  InboxModel wholedata;
  int indexvalue;
  YesSpetificDate({Key? key, required this.wholedata, required this.indexvalue})
      : super(key: key);

  @override
  State<YesSpetificDate> createState() => _YesIsitForMeState();
}

class _YesIsitForMeState extends State<YesSpetificDate> {
  InboxProvider inboxprovider = InboxProvider();
  TextEditingController timeCntroller = TextEditingController();
  bool checkBoxvalue = false;
  bool checkCalenderBoxvalue = false;

  DateTime? datepicker;
  DateTime selectedDate1 = DateTime.now();
  String selectedDate = '';
  selectDate(
    BuildContext context,
  ) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime.now().subtract(Duration(days: 182)),
      lastDate: DateTime.now(),
      helpText: "SELECT FROM DATE",
      fieldHintText: "YEAR/MONTH/DATE",
      fieldLabelText: "FROM DATE",
      errorFormatText: "Enter a Valid Date",
      errorInvalidText: "Date Out of Range",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white, // header text color
              onSurface: Colors.green, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.green, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate1) {
      setState(() {
        selectedDate1 = selected;
        final format = DateFormat('yyyy-MM-dd');
        selectedDate = format.format(selectedDate1).toString();
        log(selectedDate);
        inboxprovider.updateTODOItem(
            widget.indexvalue,
            InboxModel(
              todoText: widget.wholedata.todoText,
              dateTime: widget.wholedata.dateTime,
              status: 'finish',
              extendedate: selectedDate,
              trashStatus: widget.wholedata.trashStatus,
              somedayMaybeStatus: widget.wholedata.somedayMaybeStatus,
              referenceStatus: widget.wholedata.referenceStatus
            ));
        AppRoutes.pushAndRemoveUntil(
            context, PageTransitionType.bottomToTop, const InboxScreen());
        ToastUtils.showCustomToast(
            context, "Date Update Succesfully", Colors.green);
      });
    } else if (selected != null && selected == selectedDate1) {
      setState(() {
        selectedDate1 = selected;
        final format = DateFormat('yyyy-MM-dd');
        selectedDate = format.format(selectedDate1).toString();
        log(selectedDate);
      });
    }
  }

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
        body: SingleChildScrollView(
          child: Container(
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
                      'Specific Time ?',
                      20.sp,
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
                            offset: const Offset(
                              0,
                              3,
                            ),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: '     when?',
                        labelStyle: const TextStyle(
                          color: AppColors.textColor,
                          fontFamily: "Hiragino Kaku Gothic ProN",
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 105.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.calendarWeek,
                              color: AppColors.textDarkColor,
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            text(
                              context,
                              'Calender',
                              16.sp,
                              boldText: FontWeight.w600,
                              color: AppColors.textDarkColor,
                              fontFamily: 'Hiragino Kaku Gothic ProN',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    InkWell(
                      onTap: () {
                        AppRoutes.pop(context);
                      },
                      child: Container(
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
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  child: adWidget,
                ),
              ],
            ),
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
                text: widget.wholedata.todoText,
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
              text(
                context,
                widget.wholedata.dateTime,
                10.sp,
                boldText: FontWeight.w600,
                fontFamily: "Hiragino Sans",
              ),
            ],
          )
        ],
      ),
    );
  }
}
