import 'package:bookly_app/core/models/book_model/book_model.dart';
import 'package:bookly_app/features/search/data/repos/search_repo_implementation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo}) : super(SearchInitial());
  final SearchRepoImplementation searchRepo;
  Future<void> fetchSearchResult({required String query}) async {
    if (query.isEmpty) {
      emit(SearchInitial());
    } else {
      emit(SearchLoading());
      var result = await searchRepo.fetchSearchResult(query: query);
      result.fold(
        (failure) => emit(SearchFailure(errorMessage: failure.errorMessage)),
        (books) => emit(SearchSuccess(books: books)),
      );
    }
  }
}
