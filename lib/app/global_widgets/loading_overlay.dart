
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class LoadingOverlay extends StatelessWidget {
  LoadingOverlay({Key? key, required this.child})
      : _isLoadingNotifier = ValueNotifier(false),
        super(key: key);

  final ValueNotifier<bool> _isLoadingNotifier;
  final Widget child;

  static LoadingOverlay of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<LoadingOverlay>()!;
  }

  void show() {
    _isLoadingNotifier.value = true;
  }

  void hide() {
    _isLoadingNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoadingNotifier,
      child: child,
      builder: (context, isLoading, child) {
        return Stack(
          children: [
            child!,
            if (isLoading)
              const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (isLoading)
               Center(
                child: SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                          AppLottie.loading,
                          width: 50.w,
                          height: 50.h
                      ),
                      10.pw,
                      Text(
                        allTranslations.text("pleaseWait"),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
