import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return buildShimmer();
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 20,
            );
          },
        ),
      ),
    );
  }

  Widget buildShimmer() => Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.white,
        direction: ShimmerDirection.ltr,
        period: const Duration(seconds: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 135,
              height: 135,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey[100],
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
