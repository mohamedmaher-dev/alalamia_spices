
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/global_widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global_widgets/custom_two_text.dart';


class FilterBottomSheet extends StatelessWidget {
  final List itemsList;
  var groupValue;
  final String filterName;
  final ValueChanged onChanged;
  final GestureTapCallback onSaveButtonTap;


   FilterBottomSheet({
    Key? key,
    required this.itemsList,
    required this.groupValue,
    required this.filterName,
    required this.onChanged,
    required this.onSaveButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: StatefulBuilder(
          builder: (context , mySetState){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding:  EdgeInsets.only(top: 10.0.w),
                  child: CustomTowText(
                    title: filterName,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold
                    ),
                    subWidget: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          size: 30,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ),
                  ),
                ),


                15.ph,

                ListView(
                  // crossAxisAlignment: WrapCrossAlignment.start,
                  // runSpacing: 0.0.h,
                  // runAlignment: WrapAlignment.start,
                  shrinkWrap: true,
                  primary: false,
                  children: itemsList.map((e) =>
                      RadioListTile(
                        title: Text(e.name),
                        toggleable: true,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: e,
                        groupValue: groupValue,
                        onChanged: onChanged

                      )
                  ).toList(),

                ),
               15.ph,

                CustomButtons(
                  text: allTranslations.text("save"),
                  buttonColor: Theme.of(context).secondaryHeaderColor,
                  onTap: onSaveButtonTap,
                ),


              ],
            );
          },
        )
    );
  }
}
