import 'dart:io';
import 'package:alalamia_spices/app/core/theme/app_theme.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/global_widgets/build_error_widget.dart';
import 'package:alalamia_spices/app/module/app_config/provider/app_config_provider.dart';
import 'package:alalamia_spices/app/module/splash_screen/splash_screen.dart';
import 'package:alalamia_spices/app/module/start/start.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/utils/route.dart';
import 'module/app_config/app_config_screen.dart';

class AlalamiahApp extends StatelessWidget {
  const AlalamiahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalTranslations()),
        ChangeNotifierProvider(create: (context) => UserModel(context)),
        ChangeNotifierProvider(create: (context) => CartModel(context)),
        ChangeNotifierProvider(
            create: (context) => AdvertisementSliderModel(context)),
        ChangeNotifierProvider(
            create: (context) => MainCategoriesModel(context)),
        ChangeNotifierProvider(create: (context) => MostSellingModel(context)),
        ChangeNotifierProvider(create: (context) => NewArrivalModel(context)),
        ChangeNotifierProvider(create: (context) => OffersModel(context)),
        ChangeNotifierProvider(create: (context) => CountriesModel(context)),
        ChangeNotifierProvider(create: (context) => FavoriteModel(context)),
        ChangeNotifierProvider(create: (context) => BranchesModel(context)),
        ChangeNotifierProvider(
            create: (context) => AllCategoriesModel(context)),
        ChangeNotifierProvider(create: (context) => UnitModel(context)),
        ChangeNotifierProvider(create: (context) => RequestModel(context)),
        ChangeNotifierProvider(create: (context) => UserWalletModel(context)),
        ChangeNotifierProvider(
            create: (context) => NewDeliveryPriceModel(context)),
        ChangeNotifierProvider(create: (context) => NoteModel(context)),
        ChangeNotifierProvider(create: (context) => AdsPopupModel(context)),
        ChangeNotifierProvider(create: (context) => ConnectivityNotifier()),
        ChangeNotifierProvider(create: (context) => AppConfigProvider()),
        ChangeNotifierProvider(create: (context) => CeilingPriceModel(context)),
        ChangeNotifierProvider(create: (context) => SocialMediaModel(context)),
        ChangeNotifierProvider(create: (context) => LocationModel(context)),
        ChangeNotifierProvider(
            create: (context) => ProductStatusModel(context)),
        ChangeNotifierProvider(create: (context) => SearchModel(context)),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatefulWidget {
  const MaterialAppWithTheme({super.key});

  static restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MaterialAppWithThemeState>()?.restartApp();
  }

  @override
  State<MaterialAppWithTheme> createState() => _MaterialAppWithThemeState();
}

class _MaterialAppWithThemeState extends State<MaterialAppWithTheme> {
  ThemeModel themeChangeProvider = ThemeModel();

  Future getCountryDetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    countryId = prefs.getString('countryId') ?? "";
    countryImage = prefs.getString('countryImage') ?? "";
    countryName = prefs.getString('countryName') ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    getCountryDetails(context);
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfigProvider>(context);
    var userModel = Provider.of<UserModel>(context);
    userModel.getUserInfo();
    appConfigProvider.getFirstSeen();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Widget mainWidget;

    if (appModel.token == '' && appConfigProvider.splashFirstSeen == false) {
      mainWidget = const SplashScreen();
    } else if (appModel.token == '' &&
        appConfigProvider.splashFirstSeen == true) {
      mainWidget = const AppConfigScreen();
    } else {
      mainWidget = const StartScreen();
    }
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<ThemeModel>(
        builder: (context, model, child) {
          return ScreenUtilInit(
            designSize: const Size(360, 732),
            // designSize: WidgetsBinding.instance.window.physicalSize / WidgetsBinding.instance.window.devicePixelRatio,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                key: key,
                debugShowCheckedModeBanner: false,
                home: child,
                theme: model.darkTheme == false
                    ? AppTheme.getLightTheme()
                    : AppTheme.getDarkTheme(),
                routes: Routes.routes,
                builder: (BuildContext? context, Widget? widget) {
                  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                    return BuildErrorWidget(error: errorDetails);
                  };
                  return widget!;
                },
                localizationsDelegates: const [
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate
                ],
                locale: allTranslations.locale,
                supportedLocales: allTranslations.supportedLocales(),
              );
            },
            child: userModel.errorMessage == null
                ? mainWidget
                : const AppStatusMessage(),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
