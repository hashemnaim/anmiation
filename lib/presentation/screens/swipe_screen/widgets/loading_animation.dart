import 'package:flutter/material.dart';
import '../../../core/theme/my_colors.dart';
import '../../../core/widgets/shimmer_loading.dart';

class SwipeLoadingAnimation extends StatelessWidget {
  const SwipeLoadingAnimation();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          Align(
            alignment: Alignment.bottomCenter,
            child: _WhiteCard(),
          ),
          const Positioned(child: LogoGrey(), bottom: 440)
        ],
      ),
    );
  }
}

class LogoGrey extends StatelessWidget {
  const LogoGrey();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.white),
          width: 85,
          height: 85,
        ),
        Container(
          width: 77,
          height: 77,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0), color: MyColors.grey),
          child: const ShimmerLoading(),
        ),
      ],
    );
  }
}

class _WhiteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 465,
        child: Column(
          children: [
            const SizedBox(height: 40),
            const GreyContainer(150, 20),
            const SizedBox(height: 24),
            const GreyContainer(double.infinity, 12),
            const SizedBox(height: 14),
            const GreyContainer(double.infinity, 12),
            const SizedBox(height: 14),
            const GreyContainer(double.infinity, 12),
            const SizedBox(height: 14),
            Row(
              children: [
                const GreyContainer(212, 12),
                Expanded(child: Container(height: 12)),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              color: MyColors.searchBarGrey,
              height: 1,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [_InfoGrey(), _InfoGrey(), _InfoGrey()],
            ),
            Container(
              color: MyColors.searchBarGrey,
              height: 1,
              width: double.infinity,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      const GreyContainer(117, 28),
                      const SizedBox(width: 5),
                      const GreyContainer(117, 28),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const GreyContainer(98, 28)
                ]),
                Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(
                            color: MyColors.searchBarGrey, width: 2.5)),
                    child: const Center(
                      child: const Text(
                        '-/10',
                        style: TextStyle(
                            color: Color(0x34070707),
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 36)
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))));
  }
}

class _InfoGrey extends StatelessWidget {
  const _InfoGrey();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 22.0, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const GreyContainer(30, 30),
            const SizedBox(height: 9),
            const GreyContainer(50, 8)
          ],
        ),
      ),
    );
  }
}

class GreyContainer extends StatelessWidget {
  const GreyContainer([this.width, this.height]);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      child: const ShimmerLoading(),
      width: width,
      height: height,
      decoration: const BoxDecoration(
          color: MyColors.searchBarGrey,
          borderRadius: BorderRadius.all(Radius.circular(50))),
    );
  }
}
