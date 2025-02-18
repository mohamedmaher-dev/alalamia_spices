//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:html_unescape/html_unescape.dart';
// import 'package:zyaadah/app/core/utils/empty_padding.dart';
// import 'package:zyaadah/app/exports/provider.dart';
// import 'package:zyaadah/app/exports/widget.dart';
//
// class ProductDetailsTab extends StatefulWidget {
//   final String productOverview;
//   final String productSpecification;
//
//   const ProductDetailsTab({
//     Key? key,
//     required this.productOverview,
//     required this.productSpecification,
//   }) : super(key: key);
//
//   @override
//   State<ProductDetailsTab> createState() => _ProductDetailsTabState();
// }
//
// class _ProductDetailsTabState extends State<ProductDetailsTab> {
//   bool showOverView = true;
//   bool expandText = false;
//
//   dynamic converter() {
//     var unescape = HtmlUnescape();
//     var text = unescape.convert("&lt;strong&#62;This &quot;escaped&quot; string");
//     return text;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300.h,
//       width: MediaQuery.of(context).size.width,
//       color: Theme.of(context).primaryColor,
//       padding: EdgeInsets.symmetric(horizontal: 10.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           10.ph,
//           _buildTabBar(context),
//           AnimatedSwitcher(
//             duration: const Duration(milliseconds: 300),
//             child: _buildHtmlContent(showOverView ? widget.productOverview : widget.productSpecification)
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTabBar(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _buildTab(
//           context,
//           label: allTranslations.text("overView"),
//           isSelected: showOverView,
//           onTap: () => setState(() => showOverView = true),
//         ),
//         _buildTab(
//           context,
//           label: allTranslations.text("specifications"),
//           isSelected: !showOverView,
//           onTap: () => setState(() => showOverView = false),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTab(BuildContext context, {
//     required String label,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: SizedBox(
//         width: 150.w,
//         child: Column(
//           children: [
//             Text(label),
//             if (isSelected)
//               CustomHorizontalDivider(
//                 color: Theme.of(context).colorScheme.secondary,
//                 paddingTop: 0.w,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHtmlContent(String content) {
//     return HtmlWidget(
//       content,
//       renderMode: RenderMode.column,
//       textStyle: Theme.of(context).textTheme.bodyMedium!,
//     );
//   }
// }


import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../data/providers/translations.dart';

class CustomTabWidget extends StatefulWidget {
  final String overviewContent;
  final String specificationsContent;

  const CustomTabWidget({
    Key? key,
    required this.overviewContent,
    required this.specificationsContent,
  }) : super(key: key);

  @override
  _CustomTabWidgetState createState() => _CustomTabWidgetState();
}

class _CustomTabWidgetState extends State<CustomTabWidget> {
  bool showOverView = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabBar(context),
        15.ph,
        _buildHtmlContent(showOverView ? widget.overviewContent : widget.specificationsContent),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTab(
          context,
          label: allTranslations.text("overView"),
          isSelected: showOverView,
          onTap: () => setState(() => showOverView = true),
        ),
        _buildTab(
          context,
          label: allTranslations.text("specifications"),
          isSelected: !showOverView,
          onTap: () => setState(() => showOverView = false),
        ),
      ],
    );
  }

  Widget _buildTab(
      BuildContext context, {
        required String label,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 150.w,
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? Theme.of(context).colorScheme.secondary : null,
              ),
            ),
            if (isSelected)
              Divider(
                color: Theme.of(context).colorScheme.secondary,
                thickness: 2,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHtmlContent(String content) {
    return Text(
      content,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );
  }
}