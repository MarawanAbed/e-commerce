import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopApp/shop_layout.dart';
import 'package:shop_app/Modules/shop/register/Register_cubit.dart';
import 'package:shop_app/Shared/Network/local/shared_preference.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constant.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, ReigsterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                key: 'token', value: (state.loginModel.dataModel!.token),)
                  .then((value) {
                token = state.loginModel.dataModel!.token;
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
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'Register now to browse out hot offers',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey),
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your name';
                                }
                                return null;
                              },
                              label: 'User Name ',
                              prefix: Icons.person),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Email';
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
                              suffix: RegisterCubit
                                  .get(context)
                                  .suffix,
                              onSubmit: (value) {
                                //when i click on mark in keyboard make the same in the buttom
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              isPassword: RegisterCubit
                                  .get(context)
                                  .isPasswrodShow,
                              suffixPressed: () {
                                RegisterCubit.get(context).changePasswordVisiabty();
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
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Phone';
                                }
                                return null;
                              },
                              label: 'Phone ',
                              prefix: Icons.phone),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoading,
                            builder: (BuildContext context) {
                              return defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).userRegister(
                                          phone: phoneController.text,
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'Register',
                                  isUpperCase: true);
                            },
                            fallback: (BuildContext context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
