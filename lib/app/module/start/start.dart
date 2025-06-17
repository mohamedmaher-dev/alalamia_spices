import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/offers/offer_tab.dart';
import 'package:alalamia_spices/app/module/user/user_screen/user_screen.dart';
import 'package:alalamia_spices/app/module/user/user_screen/widget/index.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
PageController pageController = PageController(initialPage: 2);

class StartScreen extends StatefulWidget {
  const StartScreen({
    super.key,
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

int _currentIndex = 2;

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
    persistentController = PersistentTabController(initialIndex: 2);
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
    selectCountry(context, Provider.of<CountriesModel>(context, listen: false));
  }

  List<Widget> _buildScreens() {
    return [
      const CategoryTab(),
      // CartScreen(isFromProductDetails: false),
      OfferTab(),
      const HomeScreen(),
      const CartTab(isFromProductDetails: false),
      // const BranchesLocationTab()
      UserScreen(),
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
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          height: kBottomNavigationBarHeight,
          index: _currentIndex,
          backgroundColor: Colors.transparent,
          color: Color(0xFF927146),
          buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
          animationCurve: Curves.linear,
          items: <Widget>[
            Icon(
              Icons.category,
              color: Colors.white,
            ),
            Icon(
              Icons.local_offer_outlined,
              color: Colors.white,
            ),
            Icon(
              CupertinoIcons.home,
              color: Colors.white,
            ),
            badges.Badges(
              textOnly: true,
              color: Colors.white,
            ),
            Icon(
              CupertinoIcons.person,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              pageController.jumpToPage(index);
            });
          },
        ),
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
            ChangeNotifierProvider(create: (context) => FavoriteModel(context)),
            ChangeNotifierProvider(create: (context) => BranchesModel(context)),
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
            ChangeNotifierProvider(create: (context) => AdsPopupModel(context)),
            ChangeNotifierProvider(
                create: (context) => ProductStatusModel(context)),
          ],
          // child: PersistentTabView(
          //   context,
          //   controller: persistentController,
          //   screens: _buildScreens(),
          //   items: _navBarsItems(),
          //   confineToSafeArea: true,
          //   backgroundColor:
          //       Theme.of(context).primaryColor, // Default is Colors.white.
          //   handleAndroidBackButtonPress: true, // Default is true.
          //   resizeToAvoidBottomInset:
          //       true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
          //   stateManagement: true, // Default is true.
          //   hideNavigationBarWhenKeyboardAppears: true,
          //   //popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
          //   padding: const EdgeInsets.only(top: 8),
          //   isVisible: true,
          //   animationSettings: const NavBarAnimationSettings(
          //     navBarItemAnimation: ItemAnimationSettings(
          //       // Navigation Bar's items animation properties.
          //       duration: Duration(milliseconds: 400),
          //       curve: Curves.ease,
          //     ),
          //     screenTransitionAnimation: ScreenTransitionAnimationSettings(
          //       // Screen transition animation on change of selected tab.
          //       animateTabTransition: true,
          //       duration: Duration(milliseconds: 200),
          //       screenTransitionAnimationType:
          //           ScreenTransitionAnimationType.fadeIn,
          //     ),
          //   ),
          //   navBarHeight: kBottomNavigationBarHeight,
          //   navBarStyle: NavBarStyle
          //       .style6, // Choose the nav bar style with this property
          // ),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: _buildScreens(),
            onPageChanged: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
          ),
        ),
        floatingActionButton: const Align(
          alignment: Alignment.centerLeft,
          child: DraggableFloatingButton(),
        ),
      ),
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
