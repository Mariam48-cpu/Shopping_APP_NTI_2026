import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationStateInitial());
  int currentIndex = 0;
  void intent(BottomNavigationIntent intent) {
    switch (intent) {
      case ChangeTabIntent():
        _changeTab(intent.index);
    }
  }

  void _changeTab(int index) {
    currentIndex = index;
    emit(BottomNavigationStateChangedState(currentIndex));
  }
}

sealed class BottomNavigationIntent {}

class ChangeTabIntent extends BottomNavigationIntent {
  final int index;
  ChangeTabIntent(this.index);
}
