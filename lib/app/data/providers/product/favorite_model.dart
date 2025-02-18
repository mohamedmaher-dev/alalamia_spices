
import 'package:alalamia_spices/app/core/utils/url.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:flutter/material.dart';

import '../../model/new_arrival.dart';



class FavoriteModel extends QueryModel {
  FavoriteModel(super.context);
  List<int> _deletedFavoriteItems = [];
  @override
  Future loadData([BuildContext? context]) async {
    if (appModel.token != '' ) {
      List favoriteList = await fetchData(AppUrl.favorite);
      items.addAll(favoriteList.map((favorite) => Product.fromJson(favorite)).toList());
      finishLoading();
    }

  }

  List<int> get deletedFavoriteItems => _deletedFavoriteItems;

  add(String id){
    _deletedFavoriteItems.add(int.parse(id));
  }

  remove(String id){
    _deletedFavoriteItems.remove(int.parse(id));
  }

  Future saveChange() async {
    if(_deletedFavoriteItems.length != 0) {
      try {
        _deletedFavoriteItems.forEach((id) async {
          try {
            await deleteData("${AppUrl.favoriteDelete}$id", parameters: {});
            _deletedFavoriteItems.clear();
          } catch (e) {
            print(e);
          }
        });
      } catch (e) {}
    }
  }

  Future addToFavorite(String productID, [BuildContext? context]) async {
    if (appModel.token != '' && await canLoadData()) {
      Map<String, dynamic> postData = Map();
      postData.addAll({"product_id": productID});
      if (items.isNotEmpty) items.clear();
      await saveData(AppUrl.favorite, parameters: postData);
    }
    finishLoading();
  }

  deleteFromFavorite(String id) async {

      try {
        await deleteData(AppUrl.favoriteDelete + id, parameters: {});
      } catch (e) {
        print(e);
      }

  }

  Product get favorite => items[0];
}

class FavoriteData {
  List<Product>? products;
  FavoriteData({this.products});
  factory FavoriteData.fromJson(var json) {
    var list = json['data'] as List;
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();
    return FavoriteData(products: productList);
  }
}
