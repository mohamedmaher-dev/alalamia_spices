import 'dart:async';
import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:alalamia_spices/app/module/search/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/values/app_lottie.dart';
import '../../../global_widgets/custom_message.dart';
import '../../../global_widgets/custom_text_form_field.dart';
import '../../../global_widgets/product_shimmer.dart';

TextEditingController searchController = TextEditingController();

class SearchBody extends StatefulWidget {
  const SearchBody({
    super.key,
  });

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  TextEditingController searchController = TextEditingController();
  // bool isSearching = false;
  // late String searchText;
  Timer? _debounceTimer; // Timer for debouncing

  void _onSearchTextChanged(String query, SearchModel searchModel) {
    // Cancel the previous timer if it's active
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    // Start a new timer
    _debounceTimer = Timer(const Duration(milliseconds: 800), () {
      // This code will run only after the user has stopped typing for 500ms
      if (query.isNotEmpty) {
        searchModel.isSearching = true;
        searchModel.searchQuery = query;
      } else {
        searchModel.isSearching = false;
        searchModel.searchQuery = "";
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _debounceTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final searchModel = Provider.of<SearchModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.ph,

        /// search field
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: CustomTextFormField(
            onTap: () {
              searchModel.isSearching = false;
            },
            controller: searchController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            hintText: allTranslations.text("searchHintTxt"),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            suffixIcon: InkWell(
              onTap: () {
                if (searchController.text.isNotEmpty) {
                  searchController.clear();
                  setState(() {
                    searchModel.searchQuery = "";
                    searchModel.isSearching = false;
                  });
                } else {
                  if (searchController.text != "") {
                    setState(() {
                      searchModel.isSearching = true;
                      searchModel.searchQuery = searchController.text;
                    });
                  } else {
                    setState(() {
                      searchModel.isSearching = false;
                      searchModel.searchQuery = "";
                    });
                  }
                }
              },
              child: Icon(
                searchController.text.isNotEmpty
                    ? Icons.cancel_outlined
                    : Icons.search,
                size: 25,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onEditingComplete: () {
              searchController.clear();
              FocusScope.of(context).unfocus();
            },
            onChanged: (value) => _onSearchTextChanged(value, searchModel),
          ),
        ),

        /// search result text
        Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Text(
            allTranslations.text("searchResult"),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),

        15.ph,

        searchModel.isSearching == true
            ? Expanded(
                child: ChangeNotifierProvider(
                  create: (context) =>
                      SearchModel(context, searchText: searchModel.searchQuery),
                  child: Consumer<SearchModel>(
                    builder: (context, model, child) {
                      return model.isLoading || model.loadingFailed
                          ? const ProductShimmer()
                          : model.items.isEmpty
                              ? ListView(
                                  children: [
                                    Center(
                                      child: CustomMessage(
                                        message: allTranslations.text("noData"),
                                        appLottieIcon: AppLottie.noData,
                                        repeat: false,
                                      ),
                                    ),
                                  ],
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300.w,
                                    mainAxisExtent:
                                        AppConstants.mainAxisExtentProduct.h,
                                    // childAspectRatio: 3 / 6,
                                    // crossAxisSpacing: 3, // the space between them horizontally
                                    // mainAxisSpacing: 3
                                  ),
                                  itemCount: model.items.length,
                                  itemBuilder: (context, index) {
                                    return SearchResultItems(
                                      index: index,
                                      product: model.items[index],
                                    );
                                  },
                                );
                    },
                  ),
                ),
              )
            : Expanded(
                child: ListView(
                  children: [
                    Center(
                      child: CustomMessage(
                        message: allTranslations.text("noData"),
                        appLottieIcon: AppLottie.noData,
                        repeat: false,
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }
}
