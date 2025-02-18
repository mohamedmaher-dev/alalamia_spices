
import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/home/widget/home_note.dart';
import 'package:alalamia_spices/app/module/home/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import '../../global_widgets/no_internet_message.dart';





class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =  GlobalKey<RefreshIndicatorState>();
  Future<void> _handleRefresh () async{
    _refreshIndicatorKey.currentState?.show();
    return await Future.delayed(const Duration(seconds: 2), () {
      Provider.of<AdvertisementSliderModel>(context , listen: false).loadData(context);
      Provider.of<MainCategoriesModel>(context , listen: false).loadData(context);
      Provider.of<MostSellingModel>(context , listen: false).loadData(context);
      Provider.of<OffersModel>(context , listen: false).loadData(context);
      Provider.of<NewArrivalModel>(context , listen: false).loadData(context);
      Provider.of<SocialMediaModel>(context , listen: false).loadData(context);
      Provider.of<CountriesModel>(context , listen: false).loadData(context);
      Provider.of<UserWalletModel>(context , listen: false).loadData(context);
      Provider.of<NoteModel>(context , listen: false).loadData(context);
      Provider.of<ProductStatusModel>(context , listen: false).loadData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var noteModel = Provider.of<NoteModel>(context);
    // var networkStatus = Provider.of<NetworkStatus>(context);

    return ChangeNotifierProvider<ConnectivityNotifier>(
      create: (context) => ConnectivityNotifier(),
      child: Consumer<ConnectivityNotifier>(
        builder: (context , connection , child){
          return Scaffold(
            backgroundColor:  Theme.of(context).colorScheme.surface,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
              child: const CustomAppBar(
                isHome : true
              ),
            ),
            key: _scaffoldKey,
            body:  LiquidPullToRefresh(
              key: _refreshIndicatorKey,
              onRefresh: _handleRefresh,
              height: 100.h,
              animSpeedFactor: 2,
              showChildOpacityTransition: false,
              child: ListView(
                children: [

                  noteModel.items.isEmpty
                      ? 0.ph
                      : const HomeNote(),


                  const  CarouselSliders(),


                  15.ph,

                  const Categories(),



                  15.ph,
                  // this widget contain new arrival, offers & most selling products
                  const ProductBodyScreen(),






                  // const ProductCategories(),


                ],
              ),
            ),



            bottomNavigationBar: connection.hasConnection
                ? 0.ph
                : const NoInternetMessage()

          );
        },
      ),
    );
  }


}
