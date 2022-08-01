import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:trid_travel/blocs/current_week_updates_bloc/updates_bloc.dart';
import 'package:trid_travel/blocs/opportunities_bloc/opportunities_bloc.dart';
import 'package:trid_travel/blocs/previous_week_updates_bloc/get_previous_week_bloc.dart';
import 'package:trid_travel/blocs/projects_news_bloc/projects_news.dart';
import 'package:trid_travel/blocs/research_bloc/research_bloc.dart';
import 'package:trid_travel/blocs/seminar_news_bloc/seminar_news_bloc.dart';
import 'package:trid_travel/blocs/workshop_news_bloc/workshop_news_bloc.dart';
import 'package:trid_travel/cubits/side_menu_cubit/side_menu_cubit.dart';
import 'package:trid_travel/repository/api_repository.dart';
import 'package:trid_travel/services/api_service.dart';
import 'package:trid_travel/utils/menu/side_menu_provider.dart';
import 'screens/onboarding/main_onboarding_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: Colors.transparent,
    // statusBarColor: Colors.white,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        //* Get User Details - Side Menu Drawer
        BlocProvider<SideMenuCubit>(
          create: (context) => SideMenuCubit(apiRepository: ApiRepository(apiService: ApiService()))..getUserDetails(),
        ),

        //* Current Week Updates Bloc
        BlocProvider<GetUpdatesBloc>(
          create: (context) => GetUpdatesBloc(apiRepository: ApiRepository(apiService: ApiService()))..add(GetUpdatesBlocEvent()),
        ),

        //* Previous Week Updates Bloc
        BlocProvider<GetPreviousWeekBloc>(
          create: (context) => GetPreviousWeekBloc(apiRepository: ApiRepository(apiService: ApiService()))..add(GetPreviousWeekEvent()),
        ),
        //* Seminar Week Bloc
        BlocProvider<SeminarNewsBloc>(
          create: (context) => SeminarNewsBloc(apiRepository: ApiRepository(apiService: ApiService()))..add(SeminarNewsEvent()),
        ),
        //* Workshop News Bloc
        BlocProvider<WorkshopNewsBloc>(
          create: (context) => WorkshopNewsBloc(apiRepository: ApiRepository(apiService: ApiService()))..add(WorkshopNewsEvent()),
        ),
        //* Projects News Bloc
        BlocProvider<ProjectsNewsBloc>(
          create: (context) => ProjectsNewsBloc(apiRepository: ApiRepository(apiService: ApiService()))..add(ProjectsNewsEvent()),
        ),
        //* Research Bloc
        BlocProvider<ResearchBloc>(
          create: (context) => ResearchBloc(apiRepository: ApiRepository(apiService: ApiService()))..add(ResearchEvent()),
        ),
        //* Opportunities Bloc
        BlocProvider<OpportunitiesBloc>(
          create: (context) => OpportunitiesBloc(apiRepository: ApiRepository(apiService: ApiService()))..add(OpportunitiesEvent()),
        ),
      ],
      child: ChangeNotifierProvider(
        create: ((context) => SideMenuProvider()),
        child: MaterialApp(
          theme: ThemeData().copyWith(
              colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.amber, secondary: Colors.amberAccent)),
          debugShowCheckedModeBanner: false,
          home: const OnboardingPage(),
        ),
      ),
    );
  }
}
