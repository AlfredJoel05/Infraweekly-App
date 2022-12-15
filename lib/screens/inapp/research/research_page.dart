import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trid_travel/Utils/exit_alert.dart';
import 'package:trid_travel/screens/inapp/research/research_builder.dart';
import '../../../Utils/menu/side_menu.dart';

class ResearchPage extends StatefulWidget {
  const ResearchPage({Key? key}) : super(key: key);

  @override
  State<ResearchPage> createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage>
    with TickerProviderStateMixin {
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
            "Reports & Publications",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          centerTitle: true,
          // ignore: prefer_const_literals_to_create_immutables
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.amber),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        body: researchBlocBuilder(),
      ),
    );
  }
}
