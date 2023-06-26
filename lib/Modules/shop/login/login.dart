import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopApp/shop_layout.dart';
import 'package:shop_app/Modules/shop/login/login_cubit.dart';
import 'package:shop_app/Modules/shop/register/resigster.dart';
import 'package:shop_app/Shared/Network/local/shared_preference.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constant.dart';

class ShopLogInScreen extends StatelessWidget {
  ShopLogInScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                key: 'token', value: (state.loginModel.dataModel!.token),)
              .then((value) {
                token=state.loginModel.dataModel!.token;
          buildPushReplacement(context, const ShopLayout());
          });
          //save token after it i go home layout
          }
            else {
          print(state.loginModel.message);
          showToast(
          message: state.loginModel.message!, state: ToastState.ERROR);
          }
        }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to browse out hot offers',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email must be Written';
                              }
                              return null;
                            },
                            label: 'Email',
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: LoginCubit
                                .get(context)
                                .suffix,
                            onSubmit: (value) {
                              //when i click on mark in keyboard make the same in the buttom
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword: LoginCubit
                                .get(context)
                                .isPasswrodShow,
                            suffixPressed: () {
                              LoginCubit.get(context).changePasswordVisiabty();
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password must be Written';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoading,
                          builder: (BuildContext context) {
                            return defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'login',
                                isUpperCase: true);
                          },
                          fallback: (BuildContext context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  buildPushReplacement(
                                      context,  RegisterScreen());
                                },
                                child: Text('register'.toUpperCase())),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
