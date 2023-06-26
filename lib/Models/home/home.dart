class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }

  @override
  String toString() {
    return 'HomeModel(status: $status, data: $data)';
  }
}

class HomeDataModel
{
  List<BannerModel> banner=[];
  List<ProductsModel> products=[];
  HomeDataModel.fromjson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element) {
      var bannerModel = BannerModel.fromjson(element);
      banner.add(bannerModel);
    });

    json['products'].forEach((element) {
      var productsModel = ProductsModel.fromjson(element);
      products.add(productsModel);
    });
  }
}


class BannerModel{
  int? id;
  String? image;


  BannerModel.fromjson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];
  }
}

class ProductsModel
{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  bool? inFavorite;
  bool? inCart;

  ProductsModel.fromjson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorite=json['in_favorites'];
    inCart=json['in_cart'];
  }
}
