import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Layout/ShopApp/cubit/shop_app_cubit.dart';
import 'package:shop_app/Modules/shop/login/login.dart';
import 'package:shop_app/Shared/Network/local/shared_preference.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Future<dynamic> buildPushReplacement(BuildContext context,Widget widget) {
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  widget));
}
void showToast(
    {required String message,
      required ToastState state,
    }
    ) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);


enum ToastState
{
  SUCCESS,
  ERROR,
  WARING,
}

Color chooseToastColor( ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color= Colors.green;
      break;
    case ToastState.ERROR:
      color= Colors.red;
      break;
    case ToastState.WARING:
      color= Colors.amber;
      break;
  }
  return color;
}

void signOut(context)
{
  //clear token and navigate login
  CacheHelper.clearData(key: 'token').then((value)
  {
    if(value)
    {
      buildPushReplacement(context,ShopLogInScreen());
    }
  });
}


Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  model.image,
                  width: 120.0,
                  height: 120.0,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return const CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ); // Replace PlaceholderWidget with your desired error widget
                  },
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          final favorites = ShopAppCubit.get(context).favorites;
                          final isFavorite = favorites != null && favorites[model.id] == true;
                          ShopAppCubit.get(context).changeFavorite(model.id);
                        },
                        icon: Builder(
                          builder: (BuildContext context) {
                            final favorites = ShopAppCubit.get(context).favorites;
                            final isFavorite = favorites != null && favorites[model.id] == true;
                            return CircleAvatar(
                              radius: 15.0,
                              backgroundColor: (isFavorite ?? false)
                                  ? Colors.deepOrange
                                  : Colors.grey,
                              child: const Icon(
                                Icons.favorite_border,
                                size: 14.0,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
