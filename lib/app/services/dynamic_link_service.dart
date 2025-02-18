//
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
//
// /// [DynamicLinkService]
// class DynamicLinkService{
//   static final DynamicLinkService _singleton = DynamicLinkService._internal();
//   DynamicLinkService._internal();
//   static DynamicLinkService get instance => _singleton;
//
//   // Create new dynamic link
//   void createDynamicLink() async{
//     // final dynamicLinkParams = DynamicLinkParameters(
//     //   link: Uri.parse("https://alalamia.page.link/producct"),
//     //   uriPrefix: "https://alalamia.page.link",
//     //   androidParameters: const AndroidParameters(packageName: "com.alalamia.alalamia_spices"),
//     //   iosParameters: const IOSParameters(
//     //       bundleId: "com.alalamia.alalamiaSpices",
//     //       appStoreId: "6450176415"
//     //   ),
//     //   socialMetaTagParameters: SocialMetaTagParameters(
//     //     title: "Example",
//     //     imageUrl: Uri.parse("https://example.com/image.png"),
//     //   ),
//     // );
//     // final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
//     final dynamicLinkParams = DynamicLinkParameters(
//       link: Uri.parse("https://alalamia.page.link/product_details"),
//       uriPrefix: "https://alalamia.page.link",
//       androidParameters: const AndroidParameters(
//         packageName: "com.alalamia.alalamia_spices",
//         minimumVersion: 27,
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: "com.alalamia.alalamiaSpices",
//         appStoreId: "6450176415",
//         minimumVersion: "1.0.1",
//       ),
//       googleAnalyticsParameters: const GoogleAnalyticsParameters(
//         source: "twitter",
//         medium: "social",
//         campaign: "example-promo",
//       ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: "Example of a Dynamic Link",
//         imageUrl: Uri.parse("https://example.com/image.png"),
//       ),
//     );
//     final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
//     debugPrint("liiiiiiiiink${dynamicLink.shortUrl}");
//   }
// }