import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gtd/adMob/bannerAd.dart';
import 'package:gtd/all%20Screen/widgets/textWidget.dart';
import 'package:gtd/images/appImages.dart';
import 'package:gtd/providers/themeProvider.dart';
import 'package:gtd/routes/appRoutes.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../botom Nevigationbar/botomNevigatinbar.dart';
import '../inbox Screen/inboxScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool checkBoxvalue = false;
  late RewardedAd _rewardedAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final AdWidget adWidget = AdWidget(
    //   ad: AdmobHelper.getBannerAd()..load(),
    // );
    context.watch<DarkThemeProvider>().getdarkTheme();
    return Consumer<DarkThemeProvider>(builder: (context, prov, _) {
      return Scaffold(
        backgroundColor:
            prov.darkTheme == false ? AppColors.appThemeColor : Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AppImages.appspalshImg),
                    ),
                  ),
                ),
              ),
              text(
                context,
                'THE GTD',
                25.sp,
                color: prov.darkTheme == false
                    ? AppColors.textDarkColor
                    : Colors.white,
                fontFamily: "Hiragino Sans",
                boldText: FontWeight.w700,
              ),
              text(
                context,
                'For Your Task Management',
                color: prov.darkTheme == false
                    ? AppColors.textDarkColor
                    : Colors.white,
                16.sp,
                fontFamily: "Hiragino Sans",
                boldText: FontWeight.w700,
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: text(
                  context,
                  'Term of use',
                  color: prov.darkTheme == false
                      ? AppColors.textDarkColor
                      : Colors.white,
                  16.sp,
                  fontFamily: "Hiragino Sans",
                  boldText: FontWeight.w700,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: prov.darkTheme == false
                          ? AppColors.textDarkColor
                          : Colors.white,
                      fontFamily: "Hiragino Sans",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              // Container(
              //   height: 50,
              //   alignment: Alignment.bottomCenter,
              //   child: adWidget,
              // ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                  height: 205.h,
                  width: 582.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: AppColors.reedColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r)),
                            value: checkBoxvalue,
                            onChanged: (value) {
                              setState(() {
                                checkBoxvalue = value!;
                              });
                            },
                          ),
                          text(
                            context,
                            'I agree to the Terms of Use',
                            color: AppColors.textDarkColor,
                            16.sp,
                            fontFamily: "Hiragino Sans",
                            boldText: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InkWell(
                        onTap: () {
                          AppRoutes.push(context, PageTransitionType.fade,
                              MyNavigationBar());
                        },
                        child: Container(
                          height: 70.h,
                          width: 125.w,
                          decoration: BoxDecoration(
                              color: AppColors.reedColor,
                              borderRadius: BorderRadius.circular(60.r)),
                          child: Align(
                            alignment: Alignment.center,
                            child: text(
                              context,
                              'Start',
                              24.sp,
                              boldText: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }
}
