// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trid_travel/blocs/workshop_news_bloc/workshop_news_bloc.dart';
import 'package:trid_travel/models/news_model/workshop_news_model.dart';
import 'package:trid_travel/utils/scroll_behaviour.dart';
import 'package:trid_travel/utils/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

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
      print('Called Refresh event from Data Page');
      context.read<WorkshopNewsBloc>().add(WorkshopNewsRefreshEvent());
    },
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: workshopNewsDataList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final WorkshopNewsModel singleData = workshopNewsDataList[index];
        return cardBuilder(singleData);
      },
    ),
  ));
}

Widget workshopNewsWarning(BuildContext context) {
  return RefreshIndicator(
    triggerMode: RefreshIndicatorTriggerMode.onEdge,
    onRefresh: () async {
      print('Called Refresh event from Current Week Warning Page');
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
                fit: BoxFit.cover,
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

Widget cardBuilder(WorkshopNewsModel singleData) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
    child: Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Media - Image
            Container(
              width: 135,
              height: 135,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.grey,
              ),
              child: Image.memory(
                base64Decode(singleData.media),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //* Title
                  Text(
                    singleData.title,
                    style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 32, 32, 32),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  //* Description
                  Text(
                    singleData.description,
                    style: GoogleFonts.lato(
                        color: const Color.fromARGB(221, 23, 23, 23),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text(
                      'on ${singleData.createdAt.join('/')} by ${singleData.createdBy.toUpperCase()}',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
