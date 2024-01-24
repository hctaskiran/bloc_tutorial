import 'package:bloc_tutorial/bloc/cats_repostory.dart';
import 'package:bloc_tutorial/bloc/cats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsCubit extends Cubit<CatsState> {
  final ICatsRep _catsRepo;
  CatsCubit(this._catsRepo) : super(CatsInitial());

  Future<void> getCats() async {
    try {
      emit(CatsLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final response = _catsRepo.getCats();
      emit(CatsCompleted(await response));
    } on NetworkException catch (e) {
      CatsError(e.message);
    }
  }
}
