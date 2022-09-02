import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trid_travel/blocs/projects_news_bloc/projects_news.dart';
import 'package:trid_travel/models/news_model/projects_news_model.dart';
import 'package:trid_travel/utils/scroll_behaviour.dart';
import 'package:trid_travel/utils/shimmer.dart';

BlocBuilder<ProjectsNewsBloc, ProjectsNewsState> projectsNewsBlocBuilder() {
  return BlocBuilder<ProjectsNewsBloc, ProjectsNewsState>(
    builder: ((context, state) {
      if (state is ProjectsNewsLoadingState) {
        return const ShimmerLoader();
      } else if (state is ProjectsNewsLoadedState) {
        final projectsNewsDataList = state.projectsNewsData;
        return projectsNewsBuilder(context, projectsNewsDataList);
      } else if (state is ProjectsNewsErrorState) {
        return projectsNewsWarning(context);
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

Widget projectsNewsBuilder(
    BuildContext context, List<ProjectsNewsModel> projectsNewsDataList) {
  return Center(
      child: RefreshIndicator(
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
    onRefresh: () async {
      context.read<ProjectsNewsBloc>().add(ProjectsNewsRefreshEvent());
    },
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: projectsNewsDataList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final ProjectsNewsModel singleData = projectsNewsDataList[index];
        return cardBuilder(singleData);
      },
    ),
  ));
}

Widget projectsNewsWarning(BuildContext context) {
  return RefreshIndicator(
    triggerMode: RefreshIndicatorTriggerMode.onEdge,
    onRefresh: () async {
      context.read<ProjectsNewsBloc>().add(ProjectsNewsRefreshEvent());
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

Widget cardBuilder(ProjectsNewsModel singleData) {
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
              // child: Image.memory(
              //   base64Decode(singleData.media),
              //   fit: BoxFit.cover,
              // ),
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
