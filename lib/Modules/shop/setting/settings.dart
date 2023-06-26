import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopApp/cubit/shop_app_cubit.dart';
import 'package:shop_app/Shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = ShopAppCubit
            .get(context)
            .userData;
        nameController.text = model!.dataModel!.name!;
        emailController.text = model.dataModel!.email!;
        phoneController.text = model.dataModel!.phone!;
        return ConditionalBuilder(
          condition: ShopAppCubit
              .get(context)
              .userData != null,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if(state is ShopAppUpdateProfileLoading)
                      const LinearProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(
                          height: 20,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Name must not be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        label: 'Email',
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        function: () {
                          if(formKey.currentState!.validate()) {
                            ShopAppCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text
                            );
                          }
                        },
                        text: 'Update',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange,),);
          },
        );
      },
    );
  }
}
