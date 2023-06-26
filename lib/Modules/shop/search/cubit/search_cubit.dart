import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/Models/search/search.dart';
import 'package:shop_app/Shared/Network/end_points.dart';
import 'package:shop_app/Shared/Network/remotely/dio_helper.dart';
import 'package:shop_app/Shared/components/constant.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? model;

  search(String text)
  {
    emit(SearchLoading());
    DioHelper.postData(
        url: SEARCH,
        data: {
          'text':text
        },
      token: token
    ).then((value)
    {
      Map<String, dynamic> responseData = value.data;
      model=SearchModel.fromJson(responseData);
      emit(SearchSuccess());
    }).catchError((er)
    {
      print(er.toString());
      emit(SearchError());
    });

  }
}
