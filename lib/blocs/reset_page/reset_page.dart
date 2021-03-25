import 'package:bloc/bloc.dart';

class ResetPageCubit extends Cubit<int> {
  ResetPageCubit(int initialState): super(initialState);

  void reset() => emit(1);
  void setPage(int page) => emit(page);

  @override
  void onChange(Change<int> change) {
    print('Resetting to Trending page ');
    super.onChange(change);
  }
}