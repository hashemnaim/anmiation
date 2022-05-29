import 'package:flutter/material.dart';

import '../../../../data/virtual_consultant_data.dart';
import '../../../core/theme/my_styles.dart';
import '../../../core/widgets/opinion_container.dart';

class ChatStartConsultant extends StatelessWidget {
  const ChatStartConsultant({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 27),
          const VirtualConsultantCircularImage(radius: 55),
          const SizedBox(height: 10),
          Text(virtualConsultantName, style: MyStyles.nameTextStart),
          const SizedBox(height: 3),
          Text('Persönlicher Investmentguide', style: MyStyles.subTitle),
          const SizedBox(height: 27),
        ],
      ),
    );
  }
}
