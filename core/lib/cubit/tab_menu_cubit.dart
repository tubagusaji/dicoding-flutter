import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../core.dart';

part 'tab_menu_state.dart';

class TabMenuCubit extends Cubit<TabMenuState> {
  TabMenuCubit() : super(TabMenuState(MenuTabState.Movie));
  
  void changeMenu(MenuTabState menu)
  {
    emit(TabMenuState(menu));
  }
}
