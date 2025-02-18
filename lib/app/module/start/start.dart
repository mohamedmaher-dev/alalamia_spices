import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/offers/offer_tab.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../branches/branches_location_tab.dart';
import '../cart/cart_tab.dart';
import '../categories/category_tab.dart';
import '../home/home_screen.dart';
import '../../module/product_details/widget/badges.dart' as badges;

late PersistentTabController persistentController;

class StartScreen extends StatefulWidget {
  const StartScreen({
    super.key,
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

int _currentIndex = 0;

class _StartScreenState extends State<StartScreen> {
  var fcm = FirebaseMessaging.instance;

  //  requestPermission() async{
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   if(settings.authorizationStatus == AuthorizationStatus.authorized){
  //
  //   }else if (settings.authorizationStatus == AuthorizationStatus.provisional){
  //     if (kDebugMode) {
  //       print("User provisional permission");
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print("User declined has not accepted permission");
  //     }
  //
  //   }
  // }

  Future<void> _requestPermission() async {
    const permission = Permission.location;
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
    persistentController = PersistentTabController(initialIndex: 0);
    fcm.getToken().then((token) {
      if (kDebugMode) {
        print("device token = $token");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {});

    FirebaseMessaging.onMessage.listen((event) async {
      Future.delayed(Duration.zero, () {
        CustomDialog.showCustomDialog(
            context: context,
            barrierDismissible: false,
            title:
                "${event.notification!.title} \n ${event.notification!.body}",
            description: event.notification!.android!.imageUrl != null
                ? CustomCachedNetworkImage(
                    imageUrl: "${event.notification!.android!.imageUrl}",
                  )
                : null,
            withActions: true,
            withYesButton: true,
            onPressed: () {
              CustomDialog.hideCustomDialog(context);
            });
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(milliseconds: 5000), () {
        // showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) =>const AdsPopupDialog()
        // );
        PopupDialog.showPopupDialog(context);
      });
    });
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const CategoryTab(),
      // CartScreen(isFromProductDetails: false),
      const CartTab(isFromProductDetails: false),
      OfferTab(),
      const BranchesLocationTab()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      /// home
      PersistentBottomNavBarItem(
          icon: const Icon(
            CupertinoIcons.home,
            size: 20,
          ),
          inactiveIcon: Icon(
            CupertinoIcons.home,
            size: 25,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: allTranslations.text('home'),
          textStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
          activeColorPrimary: Theme.of(context).colorScheme.surface,
          inactiveColorPrimary: Theme.of(context).secondaryHeaderColor,
          activeColorSecondary: Theme.of(context).colorScheme.secondary,
          contentPadding: 5.0.h),

      /// category
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.category,
            size: 20,
          ),
          inactiveIcon: Icon(
            Icons.category,
            size: 20,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: allTranslations.text('categories'),
          textStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
          activeColorPrimary: Theme.of(context).colorScheme.surface,
          inactiveColorPrimary: Theme.of(context).secondaryHeaderColor,
          activeColorSecondary: Theme.of(context).colorScheme.secondary,
          contentPadding: 5.0.h),

      /// cart
      PersistentBottomNavBarItem(
          inactiveIcon: badges.Badges(textOnly: true),
          icon: Icon(
            CupertinoIcons.cart,
            size: 20,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: allTranslations.text('cart'),
          textStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
          activeColorPrimary: Theme.of(context).colorScheme.surface,
          inactiveColorPrimary: Theme.of(context).secondaryHeaderColor,
          activeColorSecondary: Theme.of(context).colorScheme.secondary,
          contentPadding: 5.0.h),

      /// offer
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.local_offer_outlined,
            size: 20,
          ),
          inactiveIcon: Icon(
            Icons.local_offer_outlined,
            size: 20,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: allTranslations.text('offers'),
          textStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
          activeColorPrimary: Theme.of(context).colorScheme.surface,
          inactiveColorPrimary: Theme.of(context).secondaryHeaderColor,
          activeColorSecondary: Theme.of(context).colorScheme.secondary,
          contentPadding: 5.0.h),

      /// providers
      PersistentBottomNavBarItem(
          icon: const Icon(
            CupertinoIcons.location,
            size: 20,
          ),
          inactiveIcon: Icon(
            CupertinoIcons.location,
            size: 20,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: allTranslations.text('providers'),
          textStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 12.sp),
          activeColorPrimary: Theme.of(context).colorScheme.surface,
          inactiveColorPrimary: Theme.of(context).secondaryHeaderColor,
          activeColorSecondary: Theme.of(context).colorScheme.secondary,
          contentPadding: 5.0.h),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    // persistentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var ceilingPriceModel = Provider.of<CeilingPriceModel>(context);
    var socialMedialModel = Provider.of<SocialMediaModel>(context);
    socialMedialModel.getSocialLinks();
    // ceilingPriceModel.getCeilingPrice();
    return SafeArea(
      child: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => AdvertisementSliderModel(context)),
              ChangeNotifierProvider(
                  create: (context) => MainCategoriesModel(context)),
              ChangeNotifierProvider(
                  create: (context) => MostSellingModel(context)),
              ChangeNotifierProvider(create: (context) => OffersModel(context)),
              ChangeNotifierProvider(
                  create: (context) => NewArrivalModel(context)),
              ChangeNotifierProvider(
                  create: (context) => FavoriteModel(context)),
              ChangeNotifierProvider(
                  create: (context) => BranchesModel(context)),
              ChangeNotifierProvider(
                  create: (context) => AllCategoriesModel(context)),
              ChangeNotifierProvider(create: (context) => UnitModel(context)),
              ChangeNotifierProvider(create: (context) => UserModel(context)),
              ChangeNotifierProvider(
                  create: (context) => CountriesModel(context)),
              ChangeNotifierProvider(
                  create: (context) => SocialMediaModel(context)),
              ChangeNotifierProvider(
                  create: (context) => UserWalletModel(context)),
              ChangeNotifierProvider(create: (context) => NoteModel(context)),
              ChangeNotifierProvider(
                  create: (context) => AdsPopupModel(context)),
              ChangeNotifierProvider(
                  create: (context) => ProductStatusModel(context)),
            ],
            child: PersistentTabView(
              context,
              controller: persistentController,
              screens: _buildScreens(),
              items: _navBarsItems(),
              confineToSafeArea: true,
              backgroundColor:
                  Theme.of(context).primaryColor, // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset:
                  true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardAppears: true,
              //popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
              padding: const EdgeInsets.only(top: 8),
              isVisible: true,
              animationSettings: const NavBarAnimationSettings(
                navBarItemAnimation: ItemAnimationSettings(
                  // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimationSettings(
                  // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  duration: Duration(milliseconds: 200),
                  screenTransitionAnimationType:
                      ScreenTransitionAnimationType.fadeIn,
                ),
              ),
              navBarHeight: kBottomNavigationBarHeight,
              navBarStyle: NavBarStyle
                  .style6, // Choose the nav bar style with this property
            ),
          ),
          floatingActionButton: const Align(
              alignment: Alignment.centerLeft,
              child: DraggableFloatingButton())),
    );

    // IndexedStack(
    //   index: _currentIndex,
    //   children:   [
    //     const HomeScreen(),
    //     const CategoryTab(),
    //
    //      CartTab(isFromProductDetails: false,),
    //     OfferTab(),
    //     // BranchesLocationTab()
    //
    //
    //     //  CartView(ceiling: ceiling,),
    //   ],
    // ),
    // bottomNavigationBar: BottomNavigationBar(
    //   type: BottomNavigationBarType.fixed,
    //   selectedItemColor: Colors.white,
    //   showSelectedLabels: true,
    //   mouseCursor: MouseCursor.uncontrolled,
    //   selectedFontSize: 12,
    //   unselectedFontSize: 10,
    //   unselectedLabelStyle: const TextStyle(color: Colors.white),
    //   backgroundColor: Colors.black,
    //   selectedIconTheme: const IconThemeData(size: 28 , color: Colors.white),
    //   unselectedItemColor: Colors.white,
    //   currentIndex: _currentIndex,
    //   onTap: (index) => setState(() => _currentIndex = index),
    //   // this will be set when a new tab is tapped
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: Image.asset(
    //         AppImages.navHomeGoldIcon,
    //         width: 20.0,
    //         height: 20.0,
    //         color: Colors.white,
    //       ),
    //       label: allTranslations.text('home'),
    //
    //       activeIcon: Image.asset(
    //         AppImages.navHomeGoldIcon,
    //         width: 24.0,
    //         height: 24.0,
    //       ),
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Image.asset(
    //         AppImages.navCategoryGoldIcon,
    //         width: 20.0,
    //         height: 20.0,
    //         color: Colors.white,
    //       ),
    //       label: allTranslations.text('categories'),
    //       activeIcon: Image.asset(
    //         AppImages.navHomeGoldIcon,
    //         width: 24.0,
    //         height: 24.0,
    //       ),
    //     ),
    //
    //     BottomNavigationBarItem(
    //       icon: Image.asset(
    //         AppImages.navCartGoldIcon,
    //         width: 20.0,
    //         height: 20.0,
    //         color: Colors.white,
    //       ),
    //       label: allTranslations.text('cart'),
    //       activeIcon: Image.asset(
    //         AppImages.navCartGoldIcon,
    //         width: 24.0,
    //         height: 24.0,
    //       ),
    //     ),
    //
    //
    //     BottomNavigationBarItem(
    //       icon: Image.asset(
    //         AppImages.navOffersGoldIcon,
    //         width: 20.0,
    //         height: 20.0,
    //         color: Colors.white,
    //       ),
    //       label: allTranslations.text('offers'),
    //       activeIcon: Image.asset(
    //         AppImages.navOffersGoldIcon,
    //         width: 24.0,
    //         height: 24.0,
    //       ),
    //     ),
    //
    //
    //     BottomNavigationBarItem(
    //       icon: Image.asset(
    //         AppImages.navProvidersLocationIcon,
    //         width: 20.0,
    //         height: 20.0,
    //         color: Colors.white,
    //       ),
    //       label: allTranslations.text('providers'),
    //       activeIcon: Image.asset(
    //         AppImages.navProvidersLocationIcon,
    //         width: 24.0,
    //         height: 24.0,
    //       ),
    //     ),
    //   ],
    // ),
  }
}
