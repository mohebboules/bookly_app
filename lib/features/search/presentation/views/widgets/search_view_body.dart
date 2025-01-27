import 'dart:async';

import 'package:bookly_app/core/utilities/styles.dart';
import 'package:bookly_app/features/search/presentation/manager/Cubits/search_cubit/search_cubit.dart';
import 'package:bookly_app/features/search/presentation/views/widgets/custom_search_text_field.dart';
import 'package:bookly_app/features/search/presentation/views/widgets/search_results_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  Timer? debounce;

  @override
  void initState() {
    BlocProvider.of<SearchCubit>(context).fetchSearchResult(query: '');
    super.initState();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchTextField(
            onChanged: (query) {
              onSearchChanged(context, query);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Search result',
            style: Styles.textStyle18,
          ),
          const SizedBox(
            height: 16,
          ),
          const Expanded(
            child: SearchResultListView(),
          ),
        ],
      ),
    );
  }

  void onSearchChanged(BuildContext context, String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        BlocProvider.of<SearchCubit>(context).fetchSearchResult(query: '');
      } else {
        BlocProvider.of<SearchCubit>(context).fetchSearchResult(query: query);
      }
    });
  }
}
