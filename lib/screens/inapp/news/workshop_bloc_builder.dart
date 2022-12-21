import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trid_travel/Utils/alert_dialog.dart';
import 'package:trid_travel/blocs/workshop_news_bloc/workshop_news_bloc.dart';
import 'package:trid_travel/models/news_model/workshop_news_model.dart';
import 'package:trid_travel/services/api_service.dart';
import 'package:trid_travel/utils/delete_card.dart';
import 'package:trid_travel/utils/scroll_behaviour.dart';
import 'package:trid_travel/utils/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

BlocBuilder<WorkshopNewsBloc, WorkshopNewsState> workshopNewsBlocBuilder() {
  return BlocBuilder<WorkshopNewsBloc, WorkshopNewsState>(
    builder: ((context, state) {
      if (state is WorkshopNewsLoadingState) {
        return const ShimmerLoader();
      } else if (state is WorkshopNewsLoadedState) {
        final workshopNewsDataList = state.workshopNewsData;
        return workshopNewsBuilder(context, workshopNewsDataList);
      } else if (state is WorkshopNewsErrorState) {
        return workshopNewsWarning(context);
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.amber,
          ),
          const SizedBox(
            height: 15,
          ),
          Text('$state')
        ],
      );
    }),
  );
}

Widget workshopNewsBuilder(
    BuildContext context, List<WorkshopNewsModel> workshopNewsDataList) {
  return Center(
      child: RefreshIndicator(
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
    onRefresh: () async {
      context.read<WorkshopNewsBloc>().add(WorkshopNewsRefreshEvent());
    },
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: workshopNewsDataList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final WorkshopNewsModel singleData = workshopNewsDataList[index];
        return cardBuilder(singleData, context);
      },
    ),
  ));
}

Widget workshopNewsWarning(BuildContext context) {
  return RefreshIndicator(
    triggerMode: RefreshIndicatorTriggerMode.onEdge,
    onRefresh: () async {
      context.read<WorkshopNewsBloc>().add(WorkshopNewsRefreshEvent());
    },
    color: Colors.amber,
    child: RemoveScrollGlow(
      child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 130),
          children: [
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              child: Image.asset(
                'images/error.png',
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'Oops!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Unable to process your request',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ]),
    ),
  );
}

Widget cardBuilder(WorkshopNewsModel singleData, BuildContext context,
    [bool mounted = true]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
    child: GestureDetector(
      onLongPress: () async {
        var delete = await showDeletePopup(context);
        if (delete) {
          var response = await deleteNews(singleData.id);
          if (response.statusCode == 200) {
            var body = json.decode(response.body);
            if (!mounted) return;
            showAlertDialogBox(context, body['body'], true);
            context.read<WorkshopNewsBloc>().add(WorkshopNewsRefreshEvent());
          }
        }
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //* Media - Image
                  Container(
                      width: 135,
                      height: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      ),
                      child: singleData.media.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'images/error1.png',
                              ),
                            )
                          : Image.memory(
                              base64Decode(singleData.media),
                              fit: BoxFit.contain,
                            )),
                  const SizedBox(width: 10),
                  //* Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          singleData.title,
                          style: GoogleFonts.lato(
                              color: const Color.fromARGB(255, 32, 32, 32),
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ]),
                const SizedBox(height: 20),
                //* Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    singleData.description,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.lato(
                      color: const Color.fromARGB(221, 23, 23, 23),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.normal),
                            text: "To learn more "),
                        TextSpan(
                            style: const TextStyle(color: Colors.amber),
                            text: "Click here",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Uri url = Uri.parse(singleData.link);
                                if (await canLaunchUrl(url)) {
                                  launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                      ])),
                      Text(
                        'on ${singleData.createdAt.join('/')} by ${singleData.createdBy.toUpperCase()}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    ),
  );
}
