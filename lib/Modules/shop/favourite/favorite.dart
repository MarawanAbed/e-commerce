import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopApp/cubit/shop_app_cubit.dart';
import 'package:shop_app/Shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopAppGetFavoriteLoading,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(
              ShopAppCubit.get(context).favoritesModel!.data!.data![index].product,
              context,
            ),
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
            itemCount: ShopAppCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
