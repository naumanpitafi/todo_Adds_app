import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobHelper {
  static String get bannerUnit => 'ca-app-pub-3940256099942544/6300978111';
    // static String get bannerUnit => 'ca-app-pub-8319377204356997/5986310267';
  static initialization() {
    // ignore: unnecessary_null_comparison
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd getBannerAd() {
    BannerAd bAd = BannerAd(
        size: AdSize.fullBanner,
        // adUnitId: 'ca-app-pub-8319377204356997/5986310267',
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',

        // adUnitId: BannerAd.testAdUnitId,
        listener: BannerAdListener(onAdClosed: (Ad ad) {
          print("Ad Closed");
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }, onAdLoaded: (Ad ad) {
          print('Ad Loaded');
        }, onAdOpened: (Ad ad) {
          print('Ad opened');
        }),
        request: const AdRequest());
    return bAd;
  }
}
