sealed class BottomNavigationState {}

class BottomNavigationStateInitial extends BottomNavigationState {}

class BottomNavigationStateChangedState extends BottomNavigationState {
  int index;

  BottomNavigationStateChangedState(this.index);
}
