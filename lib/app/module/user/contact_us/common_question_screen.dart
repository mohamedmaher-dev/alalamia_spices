
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/global_widgets/circular_loading.dart';
import 'package:alalamia_spices/app/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import 'package:alalamia_spices/app/exports/provider.dart';

class CommonQuestionScreen extends StatelessWidget {
    CommonQuestionScreen({Key? key}) : super(key: key);

  int selectedIndex = 0;
  bool showAnswer = false ;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommonQuestionModel>(
      create: (context) => CommonQuestionModel(context),
      child: Consumer<CommonQuestionModel>(
        builder: (context , model , child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor:  Theme.of(context).colorScheme.surface,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: const CustomAppBar(),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0.h),
                    child: Text(
                      allTranslations.text("commonQuestions"),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp
                      ),
                    ),
                  ),

                  10.ph,

                  model.isLoading || model.loadingFailed
                  ? const CircularLoading()
                  : Flexible(
                    child: ListView.builder(
                      itemCount: model.items.length,
                      itemBuilder: (context , index){
                        return Padding(
                          padding:  EdgeInsets.all(10.0.w),
                          child: StatefulBuilder(
                            builder: (context , mySetState) {
                              return InkWell(
                                onTap: (){
                                  mySetState((){
                                    selectedIndex = index;
                                  });
                                  if(showAnswer == false) {
                                    mySetState((){
                                     showAnswer = true;
                                    });
                                  }else {
                                    mySetState((){
                                      showAnswer = false;
                                    });
                                  }
                                },
                                child: Container(
                                  padding:  EdgeInsets.all(10.0.w),
                                  decoration: BoxDecoration(
                                    borderRadius:   BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${allTranslations.text("question")}${index+1}:",
                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "cairo"
                                            ),
                                          ),

                                          10.pw,
                                          SizedBox(
                                            width : MediaQuery.of(context).size.width * 0.700,
                                            child: Text(
                                              model.items[index].question.toString(),
                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "cairo"
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                      10.ph,

                                      showAnswer == false
                                        ? Center(
                                          child: Text(
                                          allTranslations.text("showAnswer"),
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9.sp
                                          ),
                                      ),
                                        )
                                        : 0.ph,

                                      selectedIndex == index && showAnswer == true
                                          ? Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Divider(),
                                              10.ph,
                                              Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                              Text(
                                                "${allTranslations.text("answer")}:",
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                              10.pw,
                                              SizedBox(
                                                width : MediaQuery.of(context).size.width * 0.800,
                                                child: Text(
                                                  model.items[index].answer.toString(),
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                      fontFamily: "cairo"
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                            ],
                                          )
                                          : 0.ph,

                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
