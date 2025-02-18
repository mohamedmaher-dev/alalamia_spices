import 'dart:io';
import 'dart:math';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/user/settings/model/merchant_model.dart';
 import 'package:alalamia_spices/app/exports/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import '../../../../core/utils/constants.dart';
import '../../../../core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/widget.dart';

 class TransferToMerchant extends StatefulWidget {
  const TransferToMerchant({Key? key}) : super(key: key);

  @override
  State<TransferToMerchant> createState() => _TransferToMerchantState();
}

class _TransferToMerchantState extends State<TransferToMerchant> {
    final TextEditingController aboutMerchantController = TextEditingController();
    int? rNum;
    File? _recordImage;
    String? recordImageName;

    File? _storeImage;
    String? storeImageName;

    bool _isLoading = false;
    bool hiddenBalance = false;


    // Future getImageFromCamera(File imageFile , String name) async {
    //   var image = await ImagePicker().getImage(source: ImageSource.camera);
    //   setState(() {
    //     imageFile = File(image!.path);
    //     name = p.basename(imageFile.path);
    //   });
    // }

    Future getImageFromGallery(File imageFile , String name) async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        imageFile = File(image!.path);
        name = p.basename(imageFile.path);
      });
    }




  @override
  void initState() {
    super.initState();
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var random =  Random();
    rNum = min + random.nextInt(max - min);
    if (kDebugMode) {
      print(rNum);
    }
  }

  @override
  void dispose() {
    super.dispose();
    aboutMerchantController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var networkStatus = Provider.of<NetworkStatus>(context);
    var connection = Provider.of<ConnectivityNotifier>(context);
    return ChangeNotifierProvider<MerchantModel>(
      create: (context) => MerchantModel(context),
      child: Consumer<MerchantModel>(
        builder: (context , model , child){
          return appModel.token == "visitor"
              ? 0.ph
              : CustomCardIconText(
              color: Theme.of(context).primaryColor,
              icon: Icons.request_page,
              iconColor: Colors.grey,
              height: 40.h,
              width: 45.w,
              itemsName: allTranslations.text("transferRequestMerchant"),
              itemsNameStyle: Theme.of(context).textTheme.bodyMedium!,
              secondIcon: Icons.arrow_forward_ios,
              secondIconColor: Colors.grey,
              onTap: () async{

                await showModalBottomSheet(
                    context: context,
                    elevation: 0.3,
                    isScrollControlled: true,
                    enableDrag: true,
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppConstants.defaultBorderRadius.w)
                      ),
                    ),
                    builder: (context) {
                      return Padding(
                        padding:  EdgeInsets.all(10.0.w),
                        child: Wrap(
                          // spacing: 20.h,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            runSpacing: 10.0.h,
                            runAlignment: WrapAlignment.spaceBetween,
                            children : [

                             BottomSheetHeader(
                                 title: allTranslations.text("transferRequestMerchant"),
                                 subTitle: allTranslations.text("transferRequestMerchantSubTitle")
                             ),

                              /// add record image
                              Container(
                                padding :   EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                    border: Border.all(color: Theme.of(context).secondaryHeaderColor)
                                ),
                                child: CustomTowText(
                                  title: allTranslations.text("addRecordImage"),
                                  titleStyle: Theme.of(context).textTheme.bodyMedium!,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  subWidget: CustomButtons(
                                    text: _recordImage == null
                                       ? allTranslations.text("file")
                                       : allTranslations.text("uploadDone"),
                                    buttonColor: Theme.of(context).secondaryHeaderColor,
                                    width: _recordImage == null ? 80.w : null,
                                    height: 35.h,
                                    onTap: () async{

                                      await  showModalBottomSheet(
                                          context: context,
                                          elevation: 0.3,
                                          isScrollControlled: true,
                                          enableDrag: true,
                                          shape:  RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(AppConstants.defaultBorderRadius.w)
                                            ),
                                          ),
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context , mySetState){
                                                return Padding(
                                                  padding: EdgeInsets.all(10.0.w),
                                                  child: Wrap(
                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                    runSpacing: 10.0.h,
                                                    runAlignment: WrapAlignment.spaceBetween,
                                                    children: [

                                                      BottomSheetHeader(
                                                          title: allTranslations.text("chosePhoto"),
                                                          subTitle: allTranslations.text("chosePhotoSubTitle")
                                                      ),

                                                      CustomSlidingPanel(
                                                        onTapCamera: () async{
                                                          var image = await ImagePicker().pickImage(source: ImageSource.camera);
                                                          setState(() {
                                                            _recordImage = File(image!.path);
                                                            recordImageName = p.basename(_recordImage!.path);
                                                          });
                                                        },
                                                        onTapGallery: () async{
                                                          var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                          setState(() {
                                                            _recordImage = File(image!.path);
                                                            recordImageName = p.basename(_storeImage!.path);
                                                          });
                                                        },
                                                      ),

                                                      20.ph,

                                                      CustomButtons(
                                                        height: 40.h,
                                                        text: allTranslations.text("save"),
                                                        buttonColor: Theme.of(context).secondaryHeaderColor,
                                                        onTap: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),

                              20.ph,

                              /// add store image
                              Container(
                                padding :   EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                    border: Border.all(color: Theme.of(context).secondaryHeaderColor)
                                ),
                                child: CustomTowText(
                                  title: allTranslations.text("addStoreImage"),
                                  titleStyle: Theme.of(context).textTheme.bodyMedium!,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  subWidget: CustomButtons(
                                    text: _storeImage == null
                                        ? allTranslations.text("file")
                                        : allTranslations.text("uploadDone"),
                                    buttonColor: Theme.of(context).secondaryHeaderColor,
                                    width: _storeImage == null ? 80.w : null,
                                    height: 35.h,
                                    onTap: () async {

                                      await  showModalBottomSheet(
                                          context: context,
                                          elevation: 0.3,
                                          isScrollControlled: true,
                                          enableDrag: true,
                                          shape:  RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(AppConstants.defaultBorderRadius.w)
                                            ),
                                          ),
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context , mySetState){
                                                return Padding(
                                                  padding: EdgeInsets.all(10.0.w),
                                                  child: Wrap(
                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                    runSpacing: 10.0.h,
                                                    runAlignment: WrapAlignment.spaceBetween,
                                                    children: [

                                                      BottomSheetHeader(title: allTranslations.text("chosePhoto"), subTitle: allTranslations.text("chosePhotoSubTitle")),

                                                      CustomSlidingPanel(
                                                        onTapCamera: () async{
                                                          var image = await ImagePicker().pickImage(source: ImageSource.camera);
                                                          setState(() {
                                                            _storeImage = File(image!.path);
                                                            storeImageName = p.basename(_storeImage!.path);
                                                          });
                                                        },
                                                        onTapGallery: () async{
                                                          var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                          setState(() {
                                                            _storeImage = File(image!.path);
                                                            storeImageName = p.basename(_storeImage!.path);
                                                          });

                                                        },
                                                      ),

                                                      20.ph,

                                                      CustomButtons(
                                                        height: 40.h,
                                                        text: allTranslations.text("save"),
                                                        buttonColor: Theme.of(context).secondaryHeaderColor,
                                                        onTap: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),

                              20.ph,

                              /// about merchant text filed

                              Container(
                                padding: EdgeInsets.all(10.0.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                    border: Border.all(color: Theme.of(context).secondaryHeaderColor)
                                ),
                                child: CustomTextFormField(
                                  maxLines: 5,
                                  controller: aboutMerchantController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  hintText: allTranslations.text("aboutMerchant"),
                                  contentPadding: EdgeInsets.symmetric(vertical: 5.h , horizontal: 10.w),
                                  inputBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),

                                ),
                              ),

                              20.ph,
                             StatefulBuilder(
                               builder: (context , mySetState){
                                 return  CustomButtons(
                                   height: 40.h,
                                   text: allTranslations.text("submitToReview"),
                                   textWidget: _isLoading == false
                                       ? null
                                       : const CircularLoading(),
                                   buttonColor: _isLoading == true
                                       ? Theme.of(context).colorScheme.surface
                                       : Theme.of(context).secondaryHeaderColor,
                                   onTap: () async{

                                     if(connection.hasConnection) {
                                       if(_recordImage != null && _storeImage != null && aboutMerchantController.text.isNotEmpty){
                                         mySetState((){
                                           _isLoading = true;
                                         });
                                         await model.sendTransferRequestMerchant(
                                             logImage: _recordImage!,
                                             // logImageName: recordImageName.toString(),
                                             storeImage: _storeImage!,
                                             // storeImageName: storeImageName.toString(),
                                             description: aboutMerchantController.text
                                         );
                                         if(model.isLoaded){
                                           mySetState((){
                                             _isLoading = false;
                                           });

                                           CustomDialog.showCustomDialog(
                                             context: context,
                                             barrierDismissible: false,
                                             title: allTranslations.text("requestSent"),
                                             icon: Lottie.asset(
                                               AppLottie.checkMark,
                                               width: 100.w,
                                               height: 100.h,
                                               repeat: false,
                                             ),
                                             withYesButton: true,
                                             withActions: true,
                                             onPressed: () {
                                               CustomDialog.hideCustomDialog(context);
                                             },
                                           );




                                           // Future.delayed(const Duration(seconds: 2) , () {
                                           //   Navigator.pop(context);
                                           // });
                                         }else {
                                           /// if there is an error
                                         }

                                       }else {
                                         CustomToast.showFlutterToast(
                                             context: context,
                                             message: allTranslations.text("MakeSureAllFields"),
                                             toastLength: Toast.LENGTH_LONG
                                         );
                                       }
                                     }else {
                                       CustomToast.showFlutterToast(
                                         context: context,
                                         message: allTranslations.text("networkConnection"),
                                         toastLength: Toast.LENGTH_LONG,
                                       );
                                     }



                                   },
                                 );
                               },
                             )
                            ]
                        ),
                      );
                    });

              }




          );
        },
      ),
    );
  }
}

