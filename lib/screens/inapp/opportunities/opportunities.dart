import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trid_travel/Utils/exit_alert.dart';
import 'package:trid_travel/Utils/menu/side_menu.dart';
import 'package:trid_travel/screens/inapp/opportunities/opportunity_builder.dart';

class OpportunitiesPage extends StatefulWidget {
  const OpportunitiesPage({Key? key}) : super(key: key);

  @override
  State<OpportunitiesPage> createState() => _OpportunitiesPageState();
}

class _OpportunitiesPageState extends State<OpportunitiesPage> with TickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          title: Text(
            "Opportunities",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          centerTitle: true,
          // ignore: prefer_const_literals_to_create_immutables
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.amber),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        body: opportunitiesBlocBuilder(),
      ),
    );
  }
}