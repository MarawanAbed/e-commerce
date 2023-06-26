import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/ShopApp/cubit/shop_app_cubit.dart';
import 'package:shop_app/Models/category/category.dart';
import 'package:shop_app/Models/home/home.dart';
import 'package:shop_app/Shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        if (state is ShopAppChangeFavoriteSuccess) {
          if (state.favoritesModel.status == false) {
            showToast(
                message: state.favoritesModel.message!,
                state: ToastState.ERROR);
          } else {
            showToast(
                message: state.favoritesModel.message!,
                state: ToastState.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).home != null &&
              ShopAppCubit.get(context).model != null,
          builder: (context) => productBuilder(ShopAppCubit.get(context).home!,
              ShopAppCubit.get(context).model!, context),
          fallback: (context) => const Center(
              child: CircularProgressIndicator(
            color: Colors.deepOrange,
          )),
        );
      },
    );
  }

  Widget productBuilder(HomeModel home, CategoriesModel model, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: home.data!.banner.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final banner = home.data!.banner[index];
                return Image.network(
                  banner.image!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 250,
                      child: const Icon(Icons.error, color: Colors.white),
                    );
                  },
                );
              },
              options: CarouselOptions(
                viewportFraction: 1.0,
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildCategories(model.data!.data[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: model.data!.data.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.65,
                children: List.generate(
                  home.data!.products.length,
                  (index) =>
                      buildGridProduct(home.data!.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductsModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(
                  model.image!,
                ),
                height: 200,
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
            ]),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopAppCubit.get(context).changeFavorite(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              ShopAppCubit.get(context).favorites[model.id]!
                                  ? Colors.deepOrange
                                  : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategories(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 150,
            child: Text(
              model.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
