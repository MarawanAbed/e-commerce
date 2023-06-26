import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/Models/login/login.dart';
import 'package:shop_app/Shared/Network/end_points.dart';
import 'package:shop_app/Shared/Network/remotely/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  LoginModel? loginModel;
  static LoginCubit get(context)=>BlocProvider.of(context);
  IconData suffix=Icons.visibility_outlined;
  bool isPasswrodShow=true;
  userLogin(
  {
  required String email,
  required String password,
  })
  {
    emit(LoginLoading());
    DioHelper.postData(
        url: LOGIN,
        data: {
        'email':email,
        'password':password,
        }
        ).then((value)
     {
        print(value.data);
        loginModel=LoginModel.fromJson(value.data);
        print(loginModel!.status);
        print(loginModel!.dataModel!.token);
        emit(LoginSuccess(loginModel!));
     }
      ).catchError((er)
    {
      print(er.toString());
      emit(LoginError(er.toString()));
    });
  }

  changePasswordVisiabty()
  {
    isPasswrodShow=!isPasswrodShow;
    suffix=isPasswrodShow ? Icons.visibility_outlined :Icons.visibility_off;
    emit(PasswordVisiability());
  }
}
