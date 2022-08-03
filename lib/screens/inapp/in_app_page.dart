import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trid_travel/models/side_menu_model/side_menu_model.dart';
import 'package:trid_travel/screens/inapp/feedback/feedback_page.dart';
import 'package:trid_travel/screens/inapp/news/news_page.dart';
import 'package:trid_travel/screens/inapp/opportunities/opportunities.dart';
import 'package:trid_travel/screens/inapp/research/research_page.dart';
import 'package:trid_travel/screens/inapp/updates/updates_page.dart';
import 'package:trid_travel/utils/menu/side_menu_provider.dart';

class InAppPage extends StatefulWidget {
  const InAppPage({Key? key}) : super(key: key);

  @override
  State<InAppPage> createState() => _InAppPageState();
}

class _InAppPageState extends State<InAppPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SideMenuProvider>(context);
    final sideMenuitem = provider.sideMenuItem;
    switch (sideMenuitem) {
      case SideMenuItems.newsMenu:
        return const NewsPage();
      case SideMenuItems.researchMenu:
        return const ResearchPage();
      case SideMenuItems.opportunitiesMenu:
        return const OpportunitiesPage();
      case SideMenuItems.feedbackMenu:
        return const FeedbackPage();
      default:
        return const UpdatesPage();
    }
  }
}
