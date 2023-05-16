// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class GoogleAdsScreen extends StatefulWidget {
//   const GoogleAdsScreen({Key? key}) : super(key: key);

//   @override
//   State<GoogleAdsScreen> createState() => _GoogleAdsScreenState();
// }

// class _GoogleAdsScreenState extends State<GoogleAdsScreen> {
//   late BannerAd _bannerAdd;
//   bool _isLoaded = false;
//   @override
//   void initState() {
//     super.initState();
//     _initBannerad();
//   }

//   _initBannerad() {
//     _bannerAdd = BannerAd(
//       size: AdSize.banner,
//       adUnitId: "ca-app-pub-3940256099942544/6300978111",
//       listener: BannerAdListener(
//         onAdLoaded: (ad) {
//           setState(() {
//             _isLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (ad, error) {},
//         onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//       ),
//       request: const AdRequest(),
//     );
//     _bannerAdd.load();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isLoaded
//         ? Container(
//             margin: const EdgeInsets.symmetric(vertical: 10),
//             height: _bannerAdd.size.height.toDouble(),
//             width: _bannerAdd.size.width.toDouble(),
//             color: Colors.transparent,
//             child: AdWidget(ad: _bannerAdd),
//           )
//         : const SizedBox();
//   }
// }
