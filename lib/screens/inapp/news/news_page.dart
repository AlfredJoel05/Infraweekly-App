import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trid_travel/Utils/exit_alert.dart';
import 'package:trid_travel/Utils/menu/side_menu.dart';
import 'package:trid_travel/screens/inapp/news/projects_bloc_builder.dart';
import 'package:trid_travel/screens/inapp/news/seminar_bloc_builder.dart';
import 'package:trid_travel/screens/inapp/news/workshop_bloc_builder.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        key: _scaffoldKey,
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
            "News",
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
              tabs: [
                Tab(
                  child: Text(
                    'Seminars & Webinars',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                ),
                Tab(
                  child: Text(
                    'Recent Products',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                ),
                Tab(
                  child: Text(
                    'Recent Projects',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                ),
              ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          seminarNewsBlocBuilder(),
          workshopNewsBlocBuilder(),
          projectsNewsBlocBuilder(),
        ]),
      ),
    );
  }
}
