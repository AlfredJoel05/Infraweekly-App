// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trid_travel/Utils/exit_alert.dart';
import 'package:trid_travel/Utils/menu/side_menu.dart';
import 'package:trid_travel/screens/inapp/updates/current_week_builder.dart';
import 'package:trid_travel/screens/inapp/updates/previous_week_builder.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({Key? key}) : super(key: key);

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[100],
        drawer: const SideMenu(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          automaticallyImplyLeading: false,
          shadowColor: Colors.black38,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text(
            "Updates",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.amber),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.amber,
              indicatorWeight: 5,
              indicatorSize: TabBarIndicatorSize.label,
              splashBorderRadius: BorderRadius.circular(30),
              tabs: [
                Tab(
                  child: Text('This week',style: GoogleFonts.poppins(
                        fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black87),
                  ),
                ),
                Tab(
                  child: Text('Previous week',style: GoogleFonts.poppins(
                        fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black87),
                  ),
                ),
              ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          currentWeekBlocBuilder(),
          previousWeekBlocBuilder()
        ]),
      ),
    );
  }
}
