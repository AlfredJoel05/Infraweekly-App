part of 'side_menu_cubit.dart';

class SideMenuState extends Equatable {

  @override
  List<Object> get props => [];
}

class SideMenuLoadingState extends SideMenuState {}

class SideMenuLoadedState extends SideMenuState {
  final UserDetailsModel userDetailsModel;

  SideMenuLoadedState(this.userDetailsModel);
  
  @override
  List<Object> get props => [userDetailsModel];
 }

class SideMenuErrorState extends SideMenuState{

  @override
  List<Object> get props => [];  
}