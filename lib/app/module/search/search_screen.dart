import 'package:alalamia_spices/app/exports/widget.dart';
import 'package:alalamia_spices/app/module/search/widget/search_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants.dart';
import '../../core/values/app_lottie.dart';
import 'package:alalamia_spices/app/exports/provider.dart';



class SearchScreen extends StatefulWidget {
   const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // TextEditingController searchController = TextEditingController();
  // bool isSearching = false;
  late String searchText;





  @override
  void initState() {
    super.initState();
    searchText = "0";
  }
  @override
  void dispose() {
    super.dispose();

    // searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var networkStatus = Provider.of<NetworkStatus>(context);
    return Consumer<ConnectivityNotifier>(
      builder: (context , connection , child) {
        return SafeArea(
          child: connection.hasConnection
              ? Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
                child: const CustomAppBar(isSearchScreen: true,),
              ),
              backgroundColor: Theme.of(context).colorScheme.surface,
              body : const SearchBody()
          )

              : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppConstants.appBarHeight.h),
              child: const CustomAppBar(isSearchScreen: true,),
            ),
            body: Column(
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
          ),
        );
      },
    );
  }
}
