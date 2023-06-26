import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopApp/cubit/shop_app_cubit.dart';
import 'package:shop_app/Layout/ShopApp/shop_layout.dart';
import 'package:shop_app/Modules/shop/login/login.dart';
import 'package:shop_app/Shared/Network/local/shared_preference.dart';
import 'package:shop_app/Shared/Network/remotely/dio_helper.dart';
import 'package:shop_app/Shared/components/bloc_observer.dart';
import 'package:shop_app/Shared/components/constant.dart';
import 'package:shop_app/Shared/style/theme_data.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget? widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLogInScreen();
    }
  }
  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});

  final Widget? startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppCubit()..getUserData()..getHomeData()..getCategories()..getFavorites(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }

}

