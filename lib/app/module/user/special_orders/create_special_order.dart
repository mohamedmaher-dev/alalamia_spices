import 'dart:io';
import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/user/special_orders/my_special_orders_screen.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/values/app_images.dart';
import '../../../core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:intl/intl.dart' as intel;
import 'package:path/path.dart' as p;

import '../../../data/model/special_order.dart';

class CreateSpecialOrder extends StatefulWidget {
  const CreateSpecialOrder({super.key});

  @override
  State<CreateSpecialOrder> createState() => _CreateSpecialOrderState();
}

class _CreateSpecialOrderState extends State<CreateSpecialOrder> {
  late TextEditingController descriptionController;
  late TextEditingController specialOrderNameController;
  late TextEditingController dateController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? chosenBranch;
  String branchId = '';
  String? selectedDate;
  DateTime _selectedDateValue =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final bool _showTitle = true;
  bool isLoading = false;
  final DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  final String _format = 'yyyy-MMMM-dd';

  File? _image;
  String? imageName;

  Future getImageFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
      imageName = p.basename(_image!.path);
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
      imageName = p.basename(_image!.path);
    });
  }

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController();
    dateController = TextEditingController();
    specialOrderNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    dateController.dispose();
    specialOrderNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var branchesModel = Provider.of<BranchesModel>(context);
    var connection = Provider.of<ConnectivityNotifier>(context);
    return SafeArea(
      child: ChangeNotifierProvider<SpecialOrderModel>(
        create: (context) => SpecialOrderModel(context),
        child: Consumer<SpecialOrderModel>(
          builder: (context, model, child) {
            branchesModel.getBranches();
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: const CustomAppBar(),
              ),
              body: connection.hasConnection
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10.0.w),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allTranslations.text("createSpecialOrder"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold),
                              ),

                              3.ph,
                              Text(
                                  allTranslations
                                      .text("createSpecialOrderSubTitle"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      )),

                              20.ph,

                              /// choose branch
                              branchesModel.isLoading ||
                                      branchesModel.loadingFailed
                                  ? const CircularLoading()
                                  : CustomCardIconText(
                                      color: Theme.of(context).primaryColor,
                                      icon: Icons.language,
                                      iconColor: Colors.grey,
                                      height: 40.h,
                                      width: 45.w,
                                      itemsName:
                                          allTranslations.text("chooseBranch"),
                                      subItemsName: chosenBranch ??
                                          branchesModel.items[0].name,
                                      itemsNameStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!,
                                      secondIcon: Icons.arrow_forward_ios,
                                      secondIconColor: Colors.grey,
                                      onTap: () async {
                                        await showModalBottomSheet(
                                            context: context,
                                            elevation: 0.3,
                                            isScrollControlled: false,
                                            enableDrag: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(
                                                      AppConstants
                                                          .defaultBorderRadius
                                                          .w)),
                                            ),
                                            builder: (context) {
                                              return StatefulBuilder(
                                                builder: (context, mySetState) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0.w),
                                                    child: Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      runSpacing: 10.0.h,
                                                      runAlignment:
                                                          WrapAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.0.w),
                                                          child: CustomTowText(
                                                            title: allTranslations
                                                                .text(
                                                                    "chooseBranch"),
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            titleStyle: Theme
                                                                    .of(context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        22.sp),
                                                            subWidget: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5.0.w),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  size: 30,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .secondaryHeaderColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        20.ph,
                                                        CustomDropDown(
                                                          listItem:
                                                              branchesModel
                                                                  .branchItems,
                                                          value: branchesModel
                                                              .currentBranch
                                                              .toString(),
                                                          hintText:
                                                              allTranslations.text(
                                                                  "chooseBranch"),
                                                          onChanged: (value) {
                                                            mySetState(() {
                                                              branchesModel
                                                                      .currentBranch =
                                                                  value;
                                                              chosenBranch =
                                                                  value;
                                                            });
                                                            for (var i = 0;
                                                                i <
                                                                    branchesModel
                                                                        .items
                                                                        .length;
                                                                i++) {
                                                              if (chosenBranch ==
                                                                  branchesModel
                                                                      .items[i]
                                                                      .name) {
                                                                branchId =
                                                                    branchesModel
                                                                        .items[
                                                                            i]
                                                                        .id;
                                                              }
                                                            }

                                                            setState(() {});

                                                            if (kDebugMode) {
                                                              print(
                                                                  "special branch id $branchId");
                                                            }
                                                          },
                                                        ),
                                                        20.ph,
                                                        CustomButtons(
                                                          height: 40.h,
                                                          text: allTranslations
                                                              .text("save"),
                                                          buttonColor: Theme.of(
                                                                  context)
                                                              .secondaryHeaderColor,
                                                          onTap: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            });
                                      }),

                              model.mustSelectBranch == ''
                                  ? 0.ph
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.h, horizontal: 20.w),
                                      child: Text(
                                        model.mustSelectBranch,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                              20.ph,

                              /// special order image
                              Container(
                                padding: EdgeInsets.all(10.0.w),
                                // alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.defaultBorderRadius.w),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      allTranslations.text("chosePhoto"),
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!,
                                    ),
                                    10.ph,
                                    Align(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          ClipOval(
                                            child: Container(
                                                width: 100.w,
                                                height: 100.h,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                child: model.isLoading ||
                                                        model.loadingFailed
                                                    ? const CircularLoading()
                                                    : _image == null
                                                        ? Image.asset(
                                                            AppImages.logo,
                                                            width: 30.w,
                                                            height: 30.h,
                                                            fit: BoxFit.contain,
                                                          )
                                                        : Image.file(
                                                            _image!,
                                                            fit: BoxFit.cover,
                                                          )),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            left: 0,
                                            child: InkWell(
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                    context: context,
                                                    elevation: 0.3,
                                                    isScrollControlled: true,
                                                    enableDrag: true,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius.circular(
                                                                  AppConstants
                                                                      .defaultBorderRadius
                                                                      .w)),
                                                    ),
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                        builder: (context,
                                                            mySetState) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0.w),
                                                            child: Wrap(
                                                              crossAxisAlignment:
                                                                  WrapCrossAlignment
                                                                      .start,
                                                              runSpacing:
                                                                  10.0.h,
                                                              runAlignment:
                                                                  WrapAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                BottomSheetHeader(
                                                                    title: allTranslations
                                                                        .text(
                                                                            "chosePhoto"),
                                                                    subTitle:
                                                                        allTranslations
                                                                            .text("chosePhotoSubTitle")),
                                                                CustomSlidingPanel(
                                                                  onTapCamera:
                                                                      () {
                                                                    getImageFromCamera();
                                                                  },
                                                                  onTapGallery:
                                                                      () {
                                                                    getImageFromGallery();
                                                                  },
                                                                ),
                                                                20.ph,
                                                                CustomButtons(
                                                                  height: 40.h,
                                                                  text: allTranslations
                                                                      .text(
                                                                          "save"),
                                                                  buttonColor: Theme.of(
                                                                          context)
                                                                      .secondaryHeaderColor,
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                height: 30.h,
                                                width: 30.w,
                                                padding: EdgeInsets.all(5.w),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(AppConstants
                                                          .defaultBorderRadius
                                                          .w),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                ),
                                                child: Container(
                                                  height: 10.h,
                                                  width: 10.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(AppConstants
                                                            .defaultBorderRadius
                                                            .w),
                                                    color: Colors.grey,
                                                  ),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              20.ph,

                              /// special order name
                              Container(
                                padding: EdgeInsets.all(10.0.w),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.defaultBorderRadius.w),
                                ),
                                child: TextFormFieldWithName(
                                  maxLines: 1,
                                  controller: specialOrderNameController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  hintTextFormField:
                                      allTranslations.text("specialOrderHint"),
                                  fieldName:
                                      allTranslations.text("specialOrderName"),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 10.w),
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return allTranslations
                                          .text("fieldRequired");
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: () {
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                              ),

                              20.ph,

                              /// description order
                              Container(
                                padding: EdgeInsets.all(10.0.w),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.defaultBorderRadius.w),
                                ),
                                child: TextFormFieldWithName(
                                  maxLines: 5,
                                  controller: descriptionController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  hintTextFormField: allTranslations
                                      .text("describeOrderHintTxt"),
                                  fieldName:
                                      allTranslations.text("describeOrder"),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 10.w),
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return allTranslations
                                          .text("fieldRequired");
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),

                              20.ph,

                              /// order date
                              CustomCardIconText(
                                  color: Theme.of(context).primaryColor,
                                  icon: Icons.date_range,
                                  iconColor: Colors.grey,
                                  height: 40.h,
                                  width: 45.w,
                                  itemsName:
                                      allTranslations.text("deliverTime"),
                                  subItemsName: dateController.text,
                                  subItemsNameStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontFamily: "cairo"),
                                  itemsNameStyle:
                                      Theme.of(context).textTheme.bodyMedium!,
                                  secondIcon: Icons.arrow_forward_ios,
                                  secondIconColor: Colors.grey,
                                  onTap: () {
                                    CustomDatePicker.showDatePicker(
                                        context: context,
                                        initialDate: DateTime(
                                            _selectedDateValue.year,
                                            _selectedDateValue.month,
                                            _selectedDateValue.day),
                                        format: _format,
                                        locale: _locale,
                                        onConfirm: (DateTime dateTime) {
                                          setState(() {
                                            dateController.text =
                                                intel.DateFormat("yyyy-MM-dd")
                                                    .format(dateTime.toLocal());
                                            _selectedDateValue = dateTime;
                                            selectedDate = dateController.text;
                                          });
                                          if (kDebugMode) {
                                            print(
                                                "*********** $dateController");
                                          }
                                        });
                                  }),

                              model.mustSelectDateError == ''
                                  ? 0.ph
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.h, horizontal: 20.w),
                                      child: Text(
                                        model.mustSelectDateError,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: CustomMessage(
                          appLottieIcon: AppLottie.noConnection,
                          message: allTranslations.text("networkConnection"),
                        ))
                      ],
                    ),
              bottomNavigationBar: StatefulBuilder(
                builder: (context, mySetState) {
                  return Padding(
                    padding: EdgeInsets.all(10.0.w),
                    child: CustomButtons(
                      width: MediaQuery.of(context).size.width,
                      height: 45.h,
                      text: allTranslations.text("submitToReview"),
                      textWidget:
                          isLoading == false ? null : const CircularLoading(),
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                      buttonColor: isLoading == true
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).secondaryHeaderColor,
                      onTap: () async {
                        if (branchId.isEmpty) {
                          branchId = branchesModel.items[0].id;
                        }
                        if (formKey.currentState!.validate() &&
                            dateController.text.isNotEmpty &&
                            branchId.isNotEmpty) {
                          model.mustSelectDateError = '';
                          model.mustSelectDateError = '';
                          mySetState(() {
                            isLoading = true;
                          });
                          SpecialOrder specialOrder = SpecialOrder(
                            branchId: branchId.toString(),
                            name: specialOrderNameController.text,
                            desc: descriptionController.text,
                            date: dateController.text,
                          );
                          if (_image == null) {
                            await model.sendSpecialOrder(
                                specialOrder, null, "");
                          } else {
                            await model.sendSpecialOrder(
                                specialOrder, _image!, imageName.toString());
                          }

                          if (model.isLoaded) {
                            CustomDialog.showCustomDialog(
                                context: context,
                                barrierDismissible: false,
                                title:
                                    allTranslations.text("specialOrderStatus"),
                                description: Text(
                                  allTranslations
                                      .text("specialOrderStatusDesc"),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                ),
                                withActions: true,
                                withYesButton: true,
                                onPressed: () {
                                  pushScreenReplacement(
                                      context, const MySpecialOrdersScreen());
                                  CustomDialog.hideCustomDialog(context);
                                });
                          } else {
                            mySetState(() {
                              isLoading = false;
                            });
                          }
                        } else {
                          mySetState(() {
                            isLoading = false;
                          });
                          formKey.currentState!.validate();
                          model.mustSelectDateError =
                              allTranslations.text('dateRequired');
                          model.mustSelectBranch =
                              allTranslations.text('branchRequired');
                        }
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
