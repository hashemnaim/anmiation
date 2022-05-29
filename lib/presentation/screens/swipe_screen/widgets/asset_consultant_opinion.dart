import 'package:flutter/material.dart';

import '../../../core/theme/my_colors.dart';
import '../../../core/theme/my_styles.dart';
import '../../../../data/virtual_consultant_data.dart';

class AssetConsultantOpinionDisplay extends StatelessWidget {
  const AssetConsultantOpinionDisplay(
    this.opinionText, {
    Key key,
  }) : super(key: key);

  final String opinionText;

  @override
  Widget build(BuildContext context) {
    final textBox = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Container(
        child: Text(
          opinionText,
          overflow: TextOverflow.visible,
          style: MyStyles.consultantOpinionText,
        ),
      ),
    );
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            Container(
              child: textBox,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: MyColors.borderGrey, width: 1),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 31,
              width: 188,
              color: Colors.white,
            )
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 17,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage(virtualConsultantPicAssetUrl),
              radius: 15,
            ),
            const SizedBox(width: 10),
            Text(
              //TODO: Handle names that end with s/x => '
              "${virtualConsultantName}s Meinung",
              style: MyStyles.mediumText15,
            ),
          ],
        ),
      ],
    );
  }
}

class AssetProArguments extends StatelessWidget {
  final List<String> arguments;
  const AssetProArguments(
    this.arguments, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: arguments.length,
      separatorBuilder: (_, __) {
        return const SizedBox(height: 24);
      },
      itemBuilder: (ctx, i) {
        return Row(
          children: [
            Icon(
              Icons.favorite_border_outlined,
              color: MyColors.mainGreen,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                arguments[i],
                style: MyStyles.normalText,
                overflow: TextOverflow.visible,
              ),
            )
          ],
        );
      },
    );
  }
}
