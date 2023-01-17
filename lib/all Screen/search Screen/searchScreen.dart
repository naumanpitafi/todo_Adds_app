import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtd/adMob/bannerAd.dart';
import 'package:gtd/providers/inboxProvider.dart';
import 'package:gtd/providers/themeProvider.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:provider/provider.dart';

import '../widgets/textWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List filterData = [];
  @override
  Widget build(BuildContext context) {
    // final AdWidget adWidget = AdWidget(
    //   ad: AdmobHelper.getBannerAd()..load(),
    // );
    // final AdWidget adWidget1 = AdWidget(
    //   ad: AdmobHelper.getBannerAd()..load(),
    // );
    // final AdWidget adWidget2 = AdWidget(
    //   ad: AdmobHelper.getBannerAd()..load(),
    // );
    context.watch<DarkThemeProvider>().getdarkTheme();
    return Consumer<DarkThemeProvider>(builder: (context, prov1, _) {
      return Consumer(builder: (context, prov, _) {
        return SafeArea(
            child: Scaffold(
          backgroundColor:
              prov1.darkTheme == false ? AppColors.appThemeColor : Colors.black,
          body: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FaIcon(
                    FontAwesomeIcons.box,
                    color: prov1.darkTheme == false
                        ? AppColors.textDarkColor
                        : Colors.white,
                    size: 20.0,
                  ),
                  text(context, 'Inbox', 20.sp,
                      boldText: FontWeight.w600,
                      color: prov1.darkTheme == false
                          ? AppColors.textDarkColor
                          : Colors.white,
                      fontFamily: "Hiragino Kaku Gothic ProN"),
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      onChanged: ((value) {
                        setState(() {
                          filterData =
                              Provider.of<InboxProvider>(context, listen: false)
                                  .todoList
                                  .where(
                                    (filt) => filt.todoText
                                        .toString()
                                        .toUpperCase()
                                        .contains(searchController.text
                                            .toString()
                                            .toUpperCase()),
                                  )
                                  .toList();
                        });
                      }),
                      decoration: InputDecoration(
                        fillColor: AppColors.whiteCat,
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            borderSide: const BorderSide(
                              width: 2,
                              color: AppColors.textColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            )),
                        filled: true,
                        // prefixIcon: icondata,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 10.w,
                        ),
                        hintText: 'Enter Description',
                        hintStyle: const TextStyle(
                          color: Color(0xff929292),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              searchController.text.isEmpty
                  ? SizedBox()
                  : filterData.length == 0
                      ? text(
                          context,
                          'Empty',
                          22.sp,
                          boldText: FontWeight.w700,
                          color: AppColors.appThemeColor,
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: filterData.isEmpty ? 0 : filterData.length,
                          itemBuilder: (BuildContext context, i) {
                            return Text(
                              filterData[i].todoText.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.sp,
                              ),
                            );
                          },
                        ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
        ));
      });
    });
  }

  textSpanWidget() {
    return Container(
      // width: 399.w,
      // height: 174.h,
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.only(
        left: 25.w,
        right: 25.w,
        top: 15.h,
        bottom: 15.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text:
                  'Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text  Text Text Text Text Text Text',
              style: TextStyle(
                fontFamily: 'Hiragino Kaku Gothic ProN',
                color: AppColors.textDarkColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              text(
                context,
                '1Hr',
                10.sp,
                boldText: FontWeight.w600,
                fontFamily: "Hiragino Sans",
              ),
              SizedBox(
                width: 7.w,
              ),
              text(
                context,
                '2022/06/08 12:32',
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
