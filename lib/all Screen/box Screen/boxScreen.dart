import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtd/adMob/bannerAd.dart';
import 'package:gtd/all%20Screen/calender%20Screen/calenderScreen.dart';
import 'package:gtd/all%20Screen/deleted%20Items%20Screen/deletedItemScreen.dart';
import 'package:gtd/all%20Screen/next%20Action/nextAction.dart';
import 'package:gtd/all%20Screen/project%20List/projectList.dart';
import 'package:gtd/all%20Screen/someDay/someDayMayBe.dart';
import 'package:gtd/all%20Screen/trsah%20Screen/trashScreen.dart';
import 'package:gtd/all%20Screen/waiting%20screen/waitingScreen.dart';
import 'package:gtd/images/appImages.dart';
import 'package:gtd/providers/calenderProvider.dart';
import 'package:gtd/providers/deleteProvider.dart';
import 'package:gtd/providers/doitProvider.dart';
import 'package:gtd/providers/nextActionProvider.dart';
import 'package:gtd/providers/projectProvider.dart';
import 'package:gtd/providers/referenceProvider.dart';
import 'package:gtd/providers/somedaymaybeProvider.dart';
import 'package:gtd/providers/trashProvider.dart';
import 'package:gtd/providers/waitingProvider.dart';
import 'package:gtd/routes/appRoutes.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../providers/themeProvider.dart';
import '../do It !!/diIT!!.dart';
import '../referenceFile Screen/referenceFileScreen.dart';
import '../widgets/textWidget.dart';

class BoxScreen extends StatefulWidget {
  const BoxScreen({Key? key}) : super(key: key);

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  NextActionProvider nextActionProv = NextActionProvider();
  DoitProvider doitProvider = DoitProvider();
  CalenderProvider calenderProvider = CalenderProvider();
  WaitingProvider waitingProvider = WaitingProvider();
  ProjectListProvider projectListprov = ProjectListProvider();
  ReferenceProvider referenceprov = ReferenceProvider();
  SomeDayMaybeProvider somedaymaybeProv = SomeDayMaybeProvider();
  TrashProvider trashProv = TrashProvider();
  // var   adWidget   ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(doitProvider.getTODOItem());
    doitProvider.getTODOItem();
    //  adWidget = AdWidget(
    //   ad: AdmobHelper.getBannerAd()..load(),
   
    // );
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(
      ad: AdmobHelper.getBannerAd()..load(),
    );
    final AdWidget adWidget1 = AdWidget(
      ad: AdmobHelper.getBannerAd()..load(),
    );
    final AdWidget adWidget2 = AdWidget(
      ad: AdmobHelper.getBannerAd()..load(),
    );
    final AdWidget adWidget3 = AdWidget(
      ad: AdmobHelper.getBannerAd()..load(),
    );
    context.watch<DoitProvider>().getTODOItem();
    context.watch<DarkThemeProvider>().getdarkTheme();
    context.watch<NextActionProvider>().getTODOItem();
    context.watch<CalenderProvider>().getTODOItem();
    context.watch<WaitingProvider>().getTODOItem();
    context.watch<ProjectListProvider>().getTODOItem();
    context.watch<ReferenceProvider>().getTODOItem();
    context.watch<SomeDayMaybeProvider>().getTODOItem();
    context.watch<TrashProvider>().getTODOItem();
    context.watch<DeleteProvider>().getDeleteItem();

    return Consumer<DarkThemeProvider>(builder: (context, prov, _) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: prov.darkTheme == false
                ? AppColors.appThemeColor
                : Colors.black,
            automaticallyImplyLeading: false,
            leading: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.folderOpen,
                  color: prov.darkTheme == false
                      ? AppColors.textDarkColor
                      : Colors.white,
                ),
                text(context, 'Box', 20.sp,
                    color: prov.darkTheme == false
                        ? AppColors.textDarkColor
                        : Colors.white,
                    boldText: FontWeight.w600,
                    fontFamily: "Hiragino Kaku Gothic ProN"),
              ],
            ),
            title: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 43.h,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.25),
                  )
                ],
                borderRadius: BorderRadius.circular(45.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    prefixIcon: const FaIcon(
                      FontAwesomeIcons.search,
                      size: 20.0,
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // labelText: ,
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      color: AppColors.textColor,
                      fontFamily: "Hiragino Kaku Gothic ProN",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: prov.darkTheme == false
                  ? AppColors.appThemeColor
                  : Colors.black,
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<DoitProvider>(builder: (context, prov, _) {
                    return InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const DoItScreen());
                        },
                        child: boxWidget(FontAwesomeIcons.rocket, 'Do it !!!',
                            prov.todoList.length.toString()));
                  }),
                  Consumer<NextActionProvider>(builder: (context, prov, _) {
                    return InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const NextAction());
                        },
                        child: boxWidget(FontAwesomeIcons.fileWaveform,
                            'Next Actions', prov.todoList.length.toString()));
                  }),
                  SizedBox(
                    height: 5,
                  ),
                 Container(
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    child: adWidget,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Consumer<CalenderProvider>(builder: (context, prov, _) {
                    return InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const CalenderScreen());
                        },
                        child: boxWidget(FontAwesomeIcons.calendar, 'Calender',
                            prov.todoList.length.toString()));
                  }),
                  Consumer<WaitingProvider>(builder: (context, prov, _) {
                    return InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const WaitingScreen());
                        },
                        child: boxWidget(FontAwesomeIcons.users, 'Waiting',
                            prov.todoList.length.toString()));
                  }),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    child: adWidget1,
                  ),
               
                  SizedBox(
                    height: 5,
                  ),
                  Consumer<ProjectListProvider>(builder: (context, prov, _) {
                    return InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const ProjectList());
                        },
                        child: boxWidget(FontAwesomeIcons.productHunt,
                            'Project List', prov.todoList.length.toString()));
                  }),
                  Consumer<ReferenceProvider>(builder: (context, prov, _) {
                    return InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const ReferenceFileScreen());
                        },
                        child: boxWidget(FontAwesomeIcons.newspaper,
                            'Reference', prov.todoList.length.toString()));
                  }),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    child: adWidget2,
                  ),
                
                  SizedBox(
                    height: 5,
                  ),
                  Consumer<SomeDayMaybeProvider>(builder: (context, prov, _) {
                    return InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const SoomeDayMayBe());
                        },
                        child: boxWidget(
                            FontAwesomeIcons.fileLines,
                            'Someday / Maybe',
                            prov.todoList.length.toString()));
                  }),
                  Consumer<TrashProvider>(builder: (context, prov, _) {
                    return InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const TrashScreen());
                        },
                        child: boxWidget(FontAwesomeIcons.trashCan, 'Trash',
                            prov.todoList.length.toString()));
                  }),
                  SizedBox(
                    height: 5,
                  ),
               
                  Container(
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    child: adWidget3,
                  ),
                  
                  SizedBox(
                    height: 5,
                  ),
                  Consumer<DeleteProvider>(builder: (context, prov, _) {
                    return InkWell(
                        onTap: () {
                          AppRoutes.push(
                              context,
                              PageTransitionType.topToBottom,
                              const DeletedItemScreen());
                        },
                        child: boxWidget(FontAwesomeIcons.trashCanArrowUp,
                            'Delete', prov.todoList.length.toString()));
                  })
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget boxWidget(
    IconData iconPic,
    String text1,
    String text2,
  ) {
    return Container(
      // height: 75.h,
      width: 400.w,
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      padding: EdgeInsets.all(15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FaIcon(
                    iconPic,
                    color: AppColors.textDarkColor,
                    size: 30.0,
                  ),
                  SizedBox(width: 15),
                  text(
                    context,
                    text1,
                    25.sp,
                    boldText: FontWeight.w500,
                    color: AppColors.textDarkColor,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  const SizedBox(width: 10),
                  text(
                    context,
                    '1Hr',
                    10.sp,
                    boldText: FontWeight.w500,
                    color: AppColors.textDarkColor,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  text(
                    context,
                    '2022/06/08 12:32',
                    10.sp,
                    boldText: FontWeight.w500,
                    color: AppColors.textDarkColor,
                  ),
                ],
              ),
            ],
          ),
          Expanded(child: Container()),
          Container(
            height: 44.h,
            width: 44.w,
            decoration: const BoxDecoration(
              color: AppColors.textDarkColor,
              shape: BoxShape.circle,
            ),
            child: Align(
              alignment: Alignment.center,
              child: text(
                context,
                text2,
                20.sp,
                boldText: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
