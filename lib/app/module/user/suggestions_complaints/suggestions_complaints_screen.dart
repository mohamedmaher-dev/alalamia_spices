
import 'dart:io';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/exports/model.dart';

class SuggestionsComplaintsScreen extends StatefulWidget {
  const SuggestionsComplaintsScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionsComplaintsScreen> createState() => _SuggestionsComplaintsScreenState();
}

class _SuggestionsComplaintsScreenState extends State<SuggestionsComplaintsScreen> {

  final TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? _image;
  String? imageName;
  bool _isLoading = false;

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
  void dispose() {
    super.dispose();
    noteController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    var connection = Provider.of<ConnectivityNotifier>(context);
    return ChangeNotifierProvider<SuggestionsComplaintsModel>(
      create: (context) => SuggestionsComplaintsModel(context),
      child: Consumer<SuggestionsComplaintsModel>(
        builder: (context , model , child) {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                    child: const CustomAppBar(),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      20.ph,
                      Stack(
                        children: [
                          ClipOval(
                            child: Container(
                                width: 200.w,
                                height: 200.h,
                                color: Theme.of(context).primaryColor,
                                child: _image == null
                                    ? Icon(
                                  Icons.note_add,
                                  size: 100,
                                  color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                                )
                                    : Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                )
                            ),

                          ),

                          Positioned(
                            bottom: 10,
                            left: 5,
                            child: InkWell(
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

                                                BottomSheetHeader(title: allTranslations.text("chosePhoto"), subTitle: allTranslations.text("chosePhotoSubTitle")),

                                                CustomSlidingPanel(
                                                  onTapCamera: () {
                                                    getImageFromCamera();
                                                  },
                                                  onTapGallery: () {
                                                    getImageFromGallery();
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
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                padding:  EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Container(
                                  height: 10.h,
                                  width: 10.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                    color: Colors.grey,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),


                      30.ph,
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(10.0.w),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:  BorderRadius.only(
                                  topLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                                  topRight: Radius.circular(AppConstants.defaultBorderRadius.w)
                              )
                          ),

                          child:  Form(
                            key: formKey,
                            child: ListView(
                              children: [


                                /// description text filed

                                Container(
                                  height: 250.h,
                                  padding: EdgeInsets.all(10.0.w),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                  ),
                                  child: TextFormFieldWithName(
                                    maxLines: 5,
                                    controller: noteController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    hintTextFormField:  allTranslations.text("suggestHintText"),
                                    fieldName: allTranslations.text("suggestSubTitle"),
                                    contentPadding: EdgeInsets.symmetric(vertical: 20.h , horizontal: 10.w),
                                    validator: (value) {
                                      if (value.length == 0) {
                                        return allTranslations.text("fieldRequired");
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (){
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
                                ),


                                20.ph,


                                /// button
                                CustomButtons(
                                  text: allTranslations.text("send"),
                                  height: 50.h,
                                  textWidget: _isLoading == false
                                      ? null
                                      : const CircularLoading(),
                                  buttonColor: _isLoading == true
                                      ? Theme.of(context).colorScheme.surface
                                      : Theme.of(context).secondaryHeaderColor,
                                  onTap: () async{

                                    if(connection.hasConnection){
                                      model.errors.clear();
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        Suggestions suggestions = Suggestions(
                                          text: noteController.text,
                                        );
                                        if (_image == null && imageName == '') {
                                          await model.sendComplaint(suggestions: suggestions);
                                        } else {
                                          await model.sendComplaint(
                                              suggestions: suggestions, image: _image, imageName: imageName);
                                        }
                                        if (model.isLoaded) {
                                          CustomDialog.showCustomDialog(
                                              context: context,
                                              barrierDismissible: false,
                                            title: allTranslations.text("suggestSentSuccessfully"),
                                            icon: Lottie.asset(
                                              AppLottie.checkMark,
                                              width: 100.w,
                                              height: 100.h,
                                              repeat: false,
                                            ),
                                            withActions: true,
                                            withYesButton: true,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              CustomDialog.hideCustomDialog(context);
                                            },
                                          );
                                        } else {

                                          formKey.currentState!.validate();
                                        }
                                      }
                                    }else {
                                      CustomToast.showFlutterToast(
                                        context: context,
                                        message: allTranslations.text("networkConnection"),
                                        toastLength: Toast.LENGTH_LONG,
                                      );
                                    }


                                  },

                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              )
          );
        },
      ),
    );


  }



}

