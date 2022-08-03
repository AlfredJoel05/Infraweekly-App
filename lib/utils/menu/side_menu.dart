import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trid_travel/Utils/exit_alert.dart';
import 'package:trid_travel/cubits/side_menu_cubit/side_menu_cubit.dart';
import 'package:trid_travel/models/side_menu_model/side_menu_model.dart';
import 'package:trid_travel/models/side_menu_model/user_details_model.dart';
import 'package:trid_travel/utils/menu/side_menu_provider.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideMenuCubit, SideMenuState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
          child: Drawer(
              elevation: 5.0,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Scaffold(
                backgroundColor: const Color.fromARGB(255, 50, 50, 50),
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state is SideMenuLoadedState
                          ? loadedDeatils(state.userDetailsModel)
                          : loadingDeatils(),
                      const SizedBox(height: 10),
                      const Divider(
                        indent: 10,
                        endIndent: 30,
                        thickness: 2,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      buildMenuItem(context,
                          text: "Updates",
                          iconData: Icons.security_update_good_outlined,
                          item: SideMenuItems.updatesMenu),
                      buildMenuItem(context,
                          text: "News",
                          iconData: Icons.newspaper,
                          item: SideMenuItems.newsMenu),
                      buildMenuItem(context,
                          text: "Research",
                          iconData: Icons.star_border,
                          item: SideMenuItems.researchMenu),
                      buildMenuItem(context,
                          text: "Opportunities",
                          iconData: Icons.change_circle_outlined,
                          item: SideMenuItems.opportunitiesMenu),
                      buildMenuItem(context,
                          text: "Feedback",
                          iconData: Icons.forum,
                          item: SideMenuItems.feedbackMenu),
                      logoutMenu(context),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

  Widget logoutMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: Text('Logout',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            onTap: () {
              Navigator.of(context).pop();
              showExitPopup(context);
            }),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context,{required String text, required IconData iconData, required SideMenuItems item}) {
    final provider = Provider.of<SideMenuProvider>(context);
    final currentItem = provider.sideMenuItem;
    final isSelected = item == currentItem;
    final Color color = isSelected ? Colors.amberAccent : Colors.white;
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 15.0)
            : const EdgeInsets.symmetric(horizontal: 2.0),
        child: ListTile(
            selected: isSelected,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            selectedTileColor: Colors.white24,
            horizontalTitleGap: 20,
            leading: Icon(iconData, color: color),
            title: Text(text,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500, color: color)),
            onTap: () => selectItem(context, item)),
      ),
    );
  }

  void selectItem(BuildContext context, SideMenuItems item) {
    final provider = Provider.of<SideMenuProvider>(context, listen: false);
    provider.setSideMenuItem(item);
  }

  Widget loadingDeatils() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.sync, color: Colors.amber, size: 100),
          Text('Syncing...',
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          Text('Fetching API...',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white))
        ],
      ),
    );
  }

  Widget loadedDeatils(UserDetailsModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.person, color: Colors.amber, size: 100),
          Text('Hi ${data.firstName} ${data.lastName}!',
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          Text(data.emailId,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white))
        ],
      ),
    );
  }
}
