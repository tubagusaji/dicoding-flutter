part of 'tab_menu_cubit.dart';

class TabMenuState extends Equatable {
  MenuTabState tab =MenuTabState.Movie;
  TabMenuState(this.tab);
  @override
  List<Object> get props => [tab];
}

