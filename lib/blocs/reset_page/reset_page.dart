import 'package:bloc/bloc.dart';

class ResetPageCubit extends Cubit<int> {
  ResetPageCubit(int initialState) : super(initialState);

  void reset() {
    emit(1);
    print('Resetting to Trending page ');
  }

  void setPage(int page) {
    emit(page);
    print("Switching to page $page");
  }
}
