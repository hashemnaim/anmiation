import 'package:flutter/material.dart';

import '../theme/my_colors.dart';
import '../../../data/virtual_consultant_data.dart';

/// "Emmas Meinung", the opinion of the Virtual Consultant ([virtualConsultantName]).
class OpinionContainer extends StatelessWidget {
  final String opinion;

  const OpinionContainer({Key key, this.opinion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Transform.translate(
          offset: const Offset(0, 15),
          child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyColors.borderGrey)),
              child: Text(opinion)),
        ),
        Positioned(
          left: 20,
          child: Container(
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const VirtualConsultantCircularImage(),
                  const SizedBox(width: 10),
                  const Text(
                      "${virtualConsultantName}s Meinung") //TODO: Handle other names, that might need an apostrophe (') in German language
                ],
              )),
        ),
      ],
    );
  }
}

class VirtualConsultantCircularImage extends StatelessWidget {
  const VirtualConsultantCircularImage({Key key, this.radius = 15})
      : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: const AssetImage(virtualConsultantPicAssetUrl),
      backgroundColor: Colors.white,
      radius: radius,
    );
  }
}
