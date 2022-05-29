import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/my_colors.dart';

/// The big background image behind a swipe item.
class SwipePictureAppBar extends StatefulWidget {
  const SwipePictureAppBar(
    this.scrollController, {
    Key key,
    @required this.context,
    @required this.opacity,
    @required this.imageUrl,
  }) : super(key: key);

  final BuildContext context;
  final ScrollController scrollController;
  final double opacity;
  final String imageUrl;

  static double kHeight = 230;

  @override
  _SwipePictureAppBarState createState() => _SwipePictureAppBarState();
}

class _SwipePictureAppBarState extends State<SwipePictureAppBar> {
  /// used for blur effect of the preview image above.
  /// ranges from 0-10.
  double sigmaX = 0.0;

  /// used for blur effect of the preview image above.
  /// ranges from 0-10.
  double sigmaY = 0.0;

  void controllerCallback() {
    if (widget.scrollController.position.pixels <= SwipePictureAppBar.kHeight) {
      setState(() {
        sigmaX = widget.scrollController.position.pixels /
            (SwipePictureAppBar.kHeight / 10);
        sigmaY = widget.scrollController.position.pixels /
            (SwipePictureAppBar.kHeight / 10);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(controllerCallback);
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Container(),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      expandedHeight: SwipePictureAppBar.kHeight,
      collapsedHeight: kToolbarHeight,
      pinned: false,
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: Image.network(
              widget.imageUrl,
              loadingBuilder: (_, __, ___) =>
                  Container(decoration: BoxDecoration(color: MyColors.grey)),
            ).image,
            fit: BoxFit.cover,
          )),
          height: SwipePictureAppBar.kHeight,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: Container(
              color: Colors.black.withOpacity(widget.opacity),
            ),
          ),
        ),
      ),
    );
  }
}
