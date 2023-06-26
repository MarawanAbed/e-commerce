part of 'shop_app_cubit.dart';

@immutable
abstract class ShopAppState {}

class ShopAppInitial extends ShopAppState {}
class ChangeBottomNav extends ShopAppState {}

class ShopAppLoading extends ShopAppState {}
class ShopAppSuccess extends ShopAppState {}
class ShopAppError extends ShopAppState {}

class ShopAppCategoryLoading extends ShopAppState {}
class ShopAppCategorySuccess extends ShopAppState {}
class ShopAppCategoryError extends ShopAppState {}

class ShopAppChangeSuccess extends ShopAppState {}

class ShopAppChangeFavoriteSuccess extends ShopAppState {
  final ChangeFavoritesModel favoritesModel;

  ShopAppChangeFavoriteSuccess(this.favoritesModel);

}
class ShopAppChangeFavoriteError extends ShopAppState {}

class ShopAppGetFavoriteLoading extends ShopAppState {}
class ShopAppGetFavoriteSuccess extends ShopAppState {}
class ShopAppGetFavoriteError extends ShopAppState {}

class ShopAppGetProfileLoading extends ShopAppState {}
class ShopAppGetProfileSuccess extends ShopAppState {
  final LoginModel loginModel;

  ShopAppGetProfileSuccess(this.loginModel);
}
class ShopAppGetProfileError extends ShopAppState {}

class ShopAppUpdateProfileLoading extends ShopAppState {}
class ShopAppUpdateProfileSuccess extends ShopAppState {
  final LoginModel loginModel;

  ShopAppUpdateProfileSuccess(this.loginModel);
}
class ShopAppUpdateProfileError extends ShopAppState {}