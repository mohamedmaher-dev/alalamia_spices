

import 'package:alalamia_spices/app/core/utils/constants.dart';
import 'package:alalamia_spices/app/core/utils/empty_padding.dart';
import 'package:alalamia_spices/app/global_widgets/carousel_slider_shimmer.dart';
import 'package:alalamia_spices/app/global_widgets/custom_cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/values/app_images.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import '../../../data/model/new_arrival.dart';

class ProductDetailsHeader extends StatefulWidget {
  final Product product;
  const ProductDetailsHeader({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  State<ProductDetailsHeader> createState() => _ProductDetailsHeaderState();
}

class _ProductDetailsHeaderState extends State<ProductDetailsHeader> {

  List productImagesList = [];

  @override
  Widget build(BuildContext context) {
    var favorite = Provider.of<FavoriteModel>(context, listen: false);
    var productStatusModel = Provider.of<ProductStatusModel>(context);
    productStatusModel.getProductStatus(productId: widget.product.id.toString());
    return  ChangeNotifierProvider<ProductImageModel>(
      create : (context) => ProductImageModel(context  , widget.product.id.toString()),
      child: Consumer<ProductImageModel>(
        builder: (context , model , child){
          // print(model.items.length);
          if(!model.isLoading || !model.loadingFailed){
            if(model.items.isNotEmpty){
              for(int i = 0; i < model.items.length; i++){
                productImagesList = model.items.sublist(1);
              }
            }
          }

          // if (kDebugMode) {
          //   print(" productImagesList.length = = ${productImagesList.length}");
          // }
          return Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            margin: EdgeInsets.only(top: 5.h),
            child: Stack(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [

                    /// product details
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 10.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Stack(

                            children: [

                              /// image swiper
                              productImagesList.isNotEmpty
                                  ? Container(
                                height: 450.h,
                                width: MediaQuery.of(context).size.width,
                                color: Theme.of(context).primaryColor,
                                child: Swiper(
                                  duration: 700,
                                  autoplay: true,
                                  itemCount: productImagesList.length,
                                  autoplayDelay: 6000,
                                  itemBuilder: (BuildContext context,int index){
                                    return model.isLoading || model.loadingFailed
                                        ? const CarouseSliderShimmer()
                                        : InkWell(
                                      onTap: () {
                                        showImageDialogFun(context , true);
                                      },
                                      child: CustomCachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: productImagesList[index].imagePath.toString(),
                                        errorImageHeight: 100.h,
                                        errorImageWidth: 100.w,
                                      ),
                                    );
                                  },

                                ),
                              )
                                  : InkWell(
                                onTap: () {
                                  showImageDialogFun(context , false);
                                },
                                child: CustomCachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: widget.product.image640.toString(),
                                  errorImageHeight: 200.h,
                                  errorImageWidth: MediaQuery.of(context).size.width,
                                ),
                              ),




                              /// favorite

                              appModel.token == "visitor"
                                  ? 0.ph
                                  : Positioned(
                                top: 5,
                                left: 10,
                                right: 10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [


                                    appModel.token == "visitor"
                                        ? 0.ph
                                        : Container(
                                      width: 35.w,
                                      height: 35.h,
                                      padding: EdgeInsets.only(left: 2.w , right: 2.w , top: 1.h , bottom: 1.h),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[100]
                                      ),
                                      child: LikeButton(
                                        size: 25,
                                        circleColor: CircleColor(
                                            start: Colors.redAccent[400]!,
                                            end: Colors.redAccent[400]!),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor:
                                          Colors.redAccent[400]!,
                                          dotSecondaryColor:
                                          Colors.redAccent[400]!,
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          return   Icon(
                                            widget.product.favorite == true
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: widget.product.favorite == true
                                                ? Colors.redAccent[400]
                                                : Colors.grey,
                                            size: 20,
                                          );
                                        },
                                        onTap: (bool isLiked) {

                                          setState(() {
                                            if (widget.product.favorite!) {
                                              widget.product.favorite = false;
//
                                              favorite.deleteFromFavorite(widget.product.id.toString());
                                            } else {
                                              widget.product.favorite = true;
//
                                              favorite.addToFavorite(widget.product.id.toString());
                                            }
                                          });

                                          return Future.value(!isLiked);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              ///  share

                              Positioned(
                                top: 50,
                                left: 10,
                                right: 10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children:  [

                                    InkWell(
                                      onTap: () {

                                        Share.share("${AppConstants.domain}/${AppConstants.productDetails}/${widget.product.id}");
                                      },
                                      child: Container(
                                        width: 35.w,
                                        height: 35.h,
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[100]
                                        ),
                                        child:  Padding(
                                          padding:  EdgeInsets.only(left: 2.w , right: 2.w , top: 1.h , bottom: 1.h),
                                          child: const Icon(
                                            Icons.share,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          20.ph,
                          Divider(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          Text(
                              widget.product.name.toString(),
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold
                              )
                          ),

                          productStatusModel.status == false
                              ? Padding(
                            padding:  EdgeInsets.only(top: 10.0.h),
                            child: Container(
                              height: 20.h,
                              width: 80.w,
                              decoration:  BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(32)
                                ),
                                color: Theme.of(context).secondaryHeaderColor , // black color
                              ),
                              child:  Center(
                                child: Text(
                                    allTranslations.text("productNotAvailable"),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 10.sp
                                    )
                                ),
                              ),
                            ),
                          )
                              : 0.ph,


                        ],
                      ),
                    ),


                  ],
                ),

                /// new arrival label

                widget.product.isNewProduct == true
                    ? Positioned(
                  top: -0.3,
                  left: -15,
                  right: -15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      allTranslations.currentLanguage == "ar"
                          ? Image.asset(AppImages.ourNewLabelAr , width: 80.w, height: 80.h,)
                          : Image.asset(AppImages.ourNewLabelEn , width: 80.w, height: 80.h,),

                      const SizedBox.shrink()

                    ],
                  ),
                )
                    : 0.ph,

                /// best seller label
                widget.product.mostSell == true
                    ? Positioned(
                  top: -0.3,
                  left: 15,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      allTranslations.currentLanguage == "ar"
                          ? Image.asset(AppImages.bestSellerLabelAr , width: 80.w, height: 80.h,)
                          : Image.asset(AppImages.bestSellerLabelEn , width: 80.w, height: 80.h,),

                      const SizedBox.shrink()

                    ],
                  ),
                )
                    : 0.ph,




              ],
            ),

          );
        },
      ),
    );
  }

   showImageDialogFun(context , bool multiImage) {

     // int currentIndex = 0;
    return showDialog(
        barrierColor: Colors.grey.withOpacity(0.7),
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return Material(

            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0.w),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                    child: multiImage == true
                     ? PhotoViewGallery.builder(
                      scrollPhysics: const BouncingScrollPhysics(),
                      itemCount: productImagesList.length,
                      builder: (context , index){
                        return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(productImagesList[index].imagePath),
                          initialScale: PhotoViewComputedScale.contained,
                          heroAttributes: PhotoViewHeroAttributes(tag: productImagesList[index].id),
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 2,
                          filterQuality: FilterQuality.high,
                        );
                      },
                      loadingBuilder: (context, event) => Center(
                        child: SizedBox(
                          width: 20.0.w,
                          height: 20.0.h,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                          ),
                        ),
                      ),
                      backgroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                          color: Theme.of(context).colorScheme.surface
                      ),
                      // pageController: pageController,
                      // onPageChanged: (index){
                      //   setState(() {
                      //     currentIndex = index;
                      //   });
                      // },
                    )
                     : PhotoView(
                      imageProvider: NetworkImage(widget.product.image640.toString()),
                      filterQuality: FilterQuality.high,
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                      heroAttributes: PhotoViewHeroAttributes(tag: widget.product.id.toString()),
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      maxScale: PhotoViewComputedScale.covered * 2,
                      basePosition: Alignment.center,
                      loadingBuilder: (context, event) => Center(
                        child: SizedBox(
                          width: 20.0.w,
                          height: 20.0.h,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                          ),
                        ),
                      ),
                      backgroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius.w),
                          color: Theme.of(context).colorScheme.surface
                      ),
                      tightMode: true,
                    ),
                  ),
                ),

                /// cancel button
                Positioned(
                  top: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding:  EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.secondary
                      ),
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),


                /// dots
                // Positioned(
                //   bottom: 100,
                //   left: 0,
                //   right: 0,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: List.generate(
                //       productImagesList.length,
                //           (index) => CustomDots(
                //               dotHeight: 10.h,
                //               dotWidth: currentIndex == index ? 25.w : 10.w,
                //               dotColor:  currentIndex == index
                //                   ? Theme.of(context).colorScheme.secondary
                //                   : Theme.of(context).secondaryHeaderColor.withOpacity(0.8)
                //           ),
                //     ),
                //   ),
                // )
              ],
            ),
          );
        });
  }
  // void createDynamicLink() async{
  //   DynamicLinkService.instance.createDynamicLink();
  // }

}
