import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopApp/cubit/shop_app_cubit.dart';
import 'package:shop_app/Models/category/category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return buildCartItem(ShopAppCubit.get(context).model!.data!.data[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              );
            },
            itemCount: ShopAppCubit.get(context).model!.data!.data.length
        );
      },
    );
  }


  Widget buildCartItem(DataModel model) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image:
              NetworkImage(
                  model.image!,
              ),
              width: 100,
              height: 100,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const Spacer(),
            const Icon(
                Icons.arrow_forward_ios
            ),
          ],
        ),
      );
}
