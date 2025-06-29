import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/core/values/app_images.dart';
import 'package:alalamia_spices/app/data/providers/translations.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final String checkoutUrl;
  const CheckoutBottomSheet({super.key, required this.checkoutUrl});

  @override
  State<CheckoutBottomSheet> createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(
              title: allTranslations.text("paymentCards"),
              subTitle: allTranslations.text("enterPaymentDetails")),
          10.ph,
          Flexible(
            child: SingleChildScrollView(
              child: SizedBox(
                height: 800.h,
                child: WebViewWidget(
                  controller: _controller,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
