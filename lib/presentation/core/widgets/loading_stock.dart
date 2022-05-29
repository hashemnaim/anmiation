import 'package:flutter/material.dart';
import '../theme/my_colors.dart';
import 'shimmer_loading.dart';

class LoadingStock extends StatelessWidget {
  const LoadingStock({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double userWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: MyColors.grey, borderRadius: BorderRadius.circular(4)),
          child: const ShimmerLoading(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 13,
              width: userWidth * 0.2,
              decoration: BoxDecoration(
                  color: MyColors.lightGrey,
                  borderRadius: BorderRadius.circular(50)),
              child: const ShimmerLoading(),
            ),
            const SizedBox(height: 4),
            Container(
              height: 10,
              width: userWidth * 0.3,
              decoration: BoxDecoration(
                  color: MyColors.lightGrey,
                  borderRadius: BorderRadius.circular(50)),
              child: const ShimmerLoading(),
            )
          ],
        )
      ],
    );
  }
}
