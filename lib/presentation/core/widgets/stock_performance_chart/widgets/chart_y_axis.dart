part of '../stock_performance_chart.dart';

class ChartYAxis extends StatelessWidget {
  final double height;
  final List<String> axisLabels;

  const ChartYAxis({@required this.height, @required this.axisLabels, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        height: height,
        right: 10,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < axisLabels.length; i++)
                  i != 0
                      ? _buildAxisText(axisLabels[i])
                      : Column(children: [
                          _buildAxisText(axisLabels[i]),
                          SizedBox(height: height * 0.076)
                        ]),
              ]),
        ));
  }

  Text _buildAxisText(String txt) {
    return Text(
      txt != null ? txt : '',
      style: MyStyles.normalText10,
    );
  }
}
