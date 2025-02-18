import 'dart:io';
import 'dart:math';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/user/personal_info/change_password_screen.dart';
import 'package:alalamia_spices/app/exports/services.dart';
import 'package:alalamia_spices/app/module/user/user_screen/user_screen.dart';
import 'package:alalamia_spices/app/module/user/user_screen/widget/balance_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../../core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:path/path.dart' as p;
import 'package:alalamia_spices/app/exports/model.dart';


String gender = "man";
class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {

  final TextEditingController nameController  = TextEditingController();
  final  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? _image;
  int? rNum;
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
  void initState() {
    super.initState();
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var random =  Random();
    rNum = min + random.nextInt(max - min);
    if (kDebugMode) {
      debugPrint(rNum.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var connection = Provider.of<ConnectivityNotifier>(context);
    return Consumer<UserModel>(
      builder: (context , userModel , child ){

        userModel.getUserInfo();
        return SafeArea(
            child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                  child: const CustomAppBar(),
                ),
                body: GestureDetector(
                  onTap: (){
                    return FocusScope.of(context).unfocus();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      20.ph,
                      Stack(
                        children: [


                          /// user image
                          ClipOval(
                            child: Container(
                                width: 100.w,
                                height: 100.h,
                                color: Theme.of(context).primaryColor,
                                child:  _image == null
                                    ? CustomCachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: userModel.userImage.toString(),
                                )
                                    : Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                )
                            ),

                          ),

                          /// add user image
                          Positioned(
                            bottom: 5,
                            left: 0,
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
                                height: 30.h,
                                width: 30.w,
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

                          /// user type
                          // Positioned(
                          //   bottom: 0,
                          //   left: 10,
                          //   right: 10,
                          //   child: Container(
                          //     alignment: Alignment.center,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                          //       color: Theme.of(context).primaryColor
                          //     ),
                          //     child: Text(
                          //       userModel.userType == "merchant"
                          //           ? allTranslations.text("merchant")
                          //           : userModel.userType == "client"
                          //           ? allTranslations.text("customer")
                          //           : userModel.userType.toString(),
                          //       style: Theme.of(context).textTheme.caption!.copyWith(
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 14.sp
                          //       ),
                          //     ),
                          //   ),
                          // ),


                        ],
                      ),

                      5.ph,
                      Container(
                        width: 80.w,
                        height: 20.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                            color: Theme.of(context).primaryColor
                        ),
                        child: Text(
                          userModel.userType == "merchant"
                              ? allTranslations.text("merchant")
                              : userModel.userType == "client"
                              ? allTranslations.text("customer")
                              : userModel.userType.toString(),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                          ),
                        ),
                      ),
                      5.ph,
                      Center(
                        child: Text(
                          userModel.userEmail.toString(),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontFamily: 'cairo'
                          ),
                        ),
                      ),
                      5.ph,

                      /// balance
                      const BalanceWidget(),


                      /// body
                      30.ph,
                      Flexible(
                        child: ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.0.w),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:  BorderRadius.only(
                                      topLeft: Radius.circular(AppConstants.defaultBorderRadius.w),
                                      topRight: Radius.circular(AppConstants.defaultBorderRadius.w)
                                  )
                              ),

                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  /// user name form field
                                  TextFormFieldWithName(
                                    controller: nameController,
                                    // initialValue: model.user.name.toString(),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    hintTextFormField: userModel.userName.toString(),
                                    fieldName: allTranslations.text("newUserName"),
                                    // validator: (value){
                                    //
                                    // },
                                    onFieldSubmitted: (){
                                      FocusScope.of(context).nextFocus();
                                    },
                                  ),


                                  20.ph,

                                  /// user phone form field
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allTranslations.text("userPhone"),
                                        style: Theme.of(context).textTheme.bodyMedium!,
                                      ),
                                      5.ph,

                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 50.h,
                                        padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                            border: Border.all(color: Colors.grey[300]!)
                                        ),
                                        child: Text(
                                          userModel.userPhone.toString(),
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              fontFamily: "cairo"
                                          ),
                                        ),
                                      )

                                    ],
                                  ),

                                  20.ph,

                                  /// user email form field
                                  TextFormFieldWithName(
                                    controller: emailController,
                                    // initialValue: model.user.email.toString(),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    hintTextFormField: userModel.userEmail.toString(),
                                    fieldName: allTranslations.text("newUserEmail"),
                                    onFieldSubmitted: (){
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),

                                  20.ph,

                                  /// gender
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allTranslations.text("gender"),
                                        style: Theme.of(context).textTheme.bodyMedium!,
                                      ),
                                      5.ph,
                                      Container(
                                          padding: EdgeInsets.all(10.0.w),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                              color:  Theme.of(context).primaryColor,
                                              border: Border.all(color: Colors.grey[400]! , width: 0)
                                          ),
                                          child: const GenderRadioButton()
                                      ),
                                    ],
                                  ),

                                  20.ph,

                                  /// user type
                                  // Column(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       allTranslations.text("userType"),
                                  //       style: Theme.of(context).textTheme.bodyMedium!,
                                  //     ),
                                  //     5.ph,
                                  //
                                  //     Container(
                                  //       width: MediaQuery.of(context).size.width,
                                  //       height: 40.h,
                                  //       padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                                  //       decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                                  //           border: Border.all(color: Colors.grey[300]!)
                                  //       ),
                                  //       child: Text(
                                  //         model.user.userType == "merchant"
                                  //         ? allTranslations.text("merchant")
                                  //         : model.user.userType == "customer"
                                  //         ? allTranslations.text("customer")
                                  //         : model.user.userType.toString(),
                                  //         style: Theme.of(context).textTheme.caption,
                                  //       ),
                                  //     )
                                  //
                                  //   ],
                                  // ),



                                  /// buttons
                                  StatefulBuilder(
                                    builder: (context , mySetState){
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: CustomButtons(
                                              height: 45.h,
                                              text: allTranslations.text("save"),
                                              textWidget: _isLoading == false
                                                  ? null
                                                  : const CircularLoading(),
                                              buttonColor: _isLoading == true
                                                  ? Theme.of(context).colorScheme.surface
                                                  : Theme.of(context).secondaryHeaderColor,
                                              onTap: () async{

                                                if(connection.hasConnection) {
                                                  mySetState(() {
                                                    _isLoading = true;
                                                  });
                                                  User user = User(
                                                      name: nameController.text.isEmpty
                                                          ? userModel.userName
                                                          : nameController.text ,
                                                      email: emailController.text.isEmpty
                                                          ? userModel.userEmail
                                                          : emailController.text,
                                                      gender: gender
                                                  );
                                                  userModel.errors.clear();



                                                  if (_image == null && imageName == '' ){
                                                    mySetState(() {

                                                    });
                                                    await userModel.editUserInfo(user);

                                                  }
                                                  else{
                                                    await userModel.editUserInfo(
                                                      user,
                                                      image: _image,
                                                      imageName: imageName,
                                                    );

                                                  }

                                                  userModel.loadData();
                                                  userModel.getUserInfo();

                                                  if (userModel.isLoaded) {
                                                    mySetState(() {
                                                      _isLoading = false;
                                                    });
                                                    CustomDialog.showCustomDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      title: allTranslations.text("editUserInfoSuccessfully"),
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
                                                        CustomLoadingDialog.hideLoading(context);
                                                      },
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

                                            ),
                                          ),
                                          10.pw,

                                          /// change password
                                          Expanded(
                                            child: CustomButtons(
                                              height: 45.h,
                                              text: allTranslations.text("changePassword"),
                                              buttonColor: Theme.of(context).secondaryHeaderColor,
                                              onTap: (){
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                                              },

                                            ),
                                          ),

                                          10.pw,

                                          /// delete account
                                          Expanded(
                                            child: CustomButtons(
                                              height: 45.h,
                                              text: allTranslations.text("deleteAccount"),
                                              buttonColor: Theme.of(context).secondaryHeaderColor,
                                              onTap: () {
                                                if(connection.hasConnection){
                                                  userModel.errors.clear();
                                                  CustomDialog.showCustomDialog(
                                                      context: context,
                                                      title: allTranslations.text("deleteAccountTitle"),
                                                      description: Text(
                                                        allTranslations.text("deleteAccountDesc"),
                                                        textAlign: TextAlign.center,
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      icon: Lottie.asset(
                                                        AppLottie.error,
                                                        width: 100.w,
                                                        height: 100.h,
                                                        repeat: false,
                                                      ),
                                                      barrierDismissible: false,
                                                      withActions: true,
                                                      withYesButton: true,
                                                      withNoButton: true,
                                                      onPressed: () async{
                                                        CustomLoadingDialog.showLoading(context);
                                                        await userModel.delete().then((value) {
                                                          CustomDialog.hideCustomDialog(context);
                                                          CustomLoadingDialog.hideLoading(context);
                                                          appModel.token = 'visitor';
                                                          pushScreenReplacement(context, const UserScreen());
                                                        });

                                                      }
                                                  );
                                                }else {
                                                  CustomToast.showFlutterToast(
                                                    context: context,
                                                    message: allTranslations.text("networkConnection"),
                                                    toastLength: Toast.LENGTH_LONG,
                                                  );
                                                }


                                              },

                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                )
            )
        );
      },
    );


  }




}


class GenderRadioButton extends StatefulWidget {
  const GenderRadioButton({Key? key}) : super(key: key);

  _GenderRadioButtonState createState() => _GenderRadioButtonState();
}

class _GenderRadioButtonState extends State<GenderRadioButton> {
  int _currentIndex = 1;

  final  List<RadioGroup> _radioOptionGroup = [
    RadioGroup(
      text: allTranslations.text('male'),
      index: 1,
    ),
    RadioGroup(
      text: allTranslations.text('female'),
      index: 2,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _radioOptionGroup
          .map((item) => Container(
        width: 150.w,
        alignment: Alignment.center,
        // padding: EdgeInsets.all(5.0.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
            color: item.index == _currentIndex
                ?  Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.surface
        ),
        child: Row(
          children: <Widget>[
            Radio(
              groupValue: _currentIndex,
              value: item.index,
              onChanged: (val) {
                setState(() {
                  gender = val == 1 ? 'man' : 'woman';
                  _currentIndex = val!;
                });
              },
              activeColor: item.index == _currentIndex
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).secondaryHeaderColor,
            ),
            Text(
              item.text,
              style: item.index == _currentIndex
                  ? Theme.of(context).textTheme.displayLarge
                  : Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ))
          .toList(),
    );
  }
}

class RadioGroup {
  String text;
  int index;
  RadioGroup({required this.text, required this.index});
}
