import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/shop/search/cubit/search_cubit.dart';
import 'package:shop_app/Shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Enter text to search';
                        }
                        return null;
                      },
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoading) const LinearProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccess)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).model!.data!.data![index],
                            context,
                            isOldPrice: false,
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
                          itemCount: SearchCubit.get(context).model!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
