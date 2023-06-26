import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/Models/login/login.dart';
import 'package:shop_app/Shared/Network/end_points.dart';
import 'package:shop_app/Shared/Network/remotely/dio_helper.dart';

part 'Register_state.dart';

class RegisterCubit extends Cubit<ReigsterState> {
  RegisterCubit() : super(RegisterInitial());

  LoginModel? loginModel;
  static RegisterCubit get(context)=>BlocProvider.of(context);
  IconData suffix=Icons.visibility_outlined;
  bool isPasswrodShow=true;
  userRegister(
  {
  required String name,
  required String email,
  required String phone,
  required String password,
  })
  {
    emit(RegisterLoading());
    DioHelper.postData(
        url: register,
        data: {
         'name':name,
        'email':email,
        'password':password,
         'phone':phone,
        }
        ).then((value)
     {
        print(value.data);
        loginModel=LoginModel.fromJson(value.data);
        print(loginModel!.status);
        print(loginModel!.dataModel!.token);
        emit(RegisterSuccess(loginModel!));
     }
      ).catchError((er)
    {
      print(er.toString());
      emit(RegisterError(er.toString()));
    });
  }

  changePasswordVisiabty()
  {
    isPasswrodShow=!isPasswrodShow;
    suffix=isPasswrodShow ? Icons.visibility_outlined :Icons.visibility_off;
    emit(RegisterPasswordVisiability());
  }
}
