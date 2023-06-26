import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/Models/category/category.dart';
import 'package:shop_app/Models/favortie/favorite.dart';
import 'package:shop_app/Models/favortie/get.dart';
import 'package:shop_app/Models/home/home.dart';
import 'package:shop_app/Models/login/login.dart';
import 'package:shop_app/Modules/shop/category/categories.dart';
import 'package:shop_app/Modules/shop/favourite/favorite.dart';
import 'package:shop_app/Modules/shop/product/product.dart';
import 'package:shop_app/Modules/shop/setting/settings.dart';
import 'package:shop_app/Shared/Network/end_points.dart';
import 'package:shop_app/Shared/Network/remotely/dio_helper.dart';
import 'package:shop_app/Shared/components/constant.dart';
import 'dart:async';

part 'shop_app_state.dart';

class ShopAppCubit extends Cubit<ShopAppState> {
  ShopAppCubit() : super(ShopAppInitial());

  static ShopAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screen = [
    const ProductsScreen(),
    const CategoryScreen(),
     FavoritesScreen(),
     SettingsScreen(),
  ];

  changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  HomeModel? home;
  Map<int, bool> favorites = {};

  getHomeData() async {
    emit(ShopAppLoading());

    const maxRetries = 3;
    int retryCount = 0;

    bool success = false;
    while (!success && retryCount < maxRetries) {
      try {
        await DioHelper.getData(
          url: HOME,
          token: token,
        ).then((value) {
          Map<String, dynamic> responseData = value.data;
          home = HomeModel.fromJson(responseData);
          home!.data!.products.forEach((element) {
            favorites.addAll({element.id!: element.inFavorite!});
          });
          emit(ShopAppSuccess());
          success = true; // Success, break the retry loop
        });
      } catch (error) {
        print(error.toString());
        retryCount++;
        if (retryCount < maxRetries) {
          await Future.delayed(
              const Duration(seconds: 2)); // Wait for 2 seconds before retrying
        }
      }
    }

    if (!success) {
      emit(ShopAppError());
    }
  }

  CategoriesModel? model;

  getCategories() async {
    emit(ShopAppCategoryLoading());

    const maxRetries = 3;
    int retryCount = 0;

    bool success = false;
    while (!success && retryCount < maxRetries) {
      try {
        await DioHelper.getData(
          url: get_categories,
        ).then((value) {
          Map<String, dynamic> responseData = value.data;
          model = CategoriesModel.fromJson(responseData);
          emit(ShopAppCategorySuccess());
          success = true; // Success, break the retry loop
        });
      } catch (error) {
        print(error.toString());
        retryCount++;
        if (retryCount < maxRetries) {
          await Future.delayed(
              const Duration(seconds: 2)); // Wait for 2 seconds before retrying
        }
      }
    }

    if (!success) {
      emit(ShopAppCategoryError());
    }
  }

  ChangeFavoritesModel? changeFavoritesModel;
  changeFavorite(int productId) {
    favorites[productId]=!favorites[productId]!;//to make it real time
    emit(ShopAppChangeSuccess());

    DioHelper.postData(
      url: FAVORITES,
      data:
      {
        'product_id':productId,
      },
      token: token
    ).then((value)
    {
      Map<String, dynamic> responseData = value.data;
      changeFavoritesModel=ChangeFavoritesModel.fromjson(responseData);
      if(!changeFavoritesModel!.status!) {
        favorites[productId]=!favorites[productId]!;
      }else
      {
        getFavorites();
      }
      emit(ShopAppChangeFavoriteSuccess(changeFavoritesModel!));
    }
    ).catchError((er){
      favorites[productId]=!favorites[productId]!;
      emit(ShopAppChangeFavoriteError());
      print(er.toString());

    });
  }


  FavoritesModel? favoritesModel;

  getFavorites() async {
    emit(ShopAppGetFavoriteLoading());
        await DioHelper.getData(
          url: FAVORITES,
          token: token
        ).then((value) {
          Map<String, dynamic> responseData = value.data;
          favoritesModel = FavoritesModel.fromJson(responseData);
          emit(ShopAppGetFavoriteSuccess());
        }).catchError((er)
        {
          emit(ShopAppGetFavoriteError());
          print(er.toString());
        });
      }

    LoginModel? userData;

  getUserData() async {
    emit(ShopAppGetProfileLoading());
    await DioHelper.getData(
        url: profile,
        token: token
    ).then((value) {
      Map<String, dynamic> responseData = value.data;
      userData = LoginModel.fromJson(responseData);
      emit(ShopAppGetProfileSuccess(userData!));
    }).catchError((er)
    {
      emit(ShopAppGetProfileError());
      print(er.toString());
    });
  }

  updateUserData({
    required String name,
    required String email,
    required String phone,

}) async {
    emit(ShopAppUpdateProfileLoading());
    await DioHelper.putData(
        url: update_profile,
        token: token,
        data:
        {
          'name':name,
          'email':email,
          'phone':phone,
        }
    ).then((value) {
      Map<String, dynamic> responseData = value.data;
      userData = LoginModel.fromJson(responseData);
      emit(ShopAppUpdateProfileSuccess(userData!));
    }).catchError((er)
    {
      emit(ShopAppUpdateProfileError());
      print(er.toString());
    });
  }

  //i take userData in update cuz he listen field so that he will put new data in her place

}
