import 'model/routing_data.dart';

//TODO: Verschieben
extension StringExtenstion on String {
  RoutingData get getRoutingData {
    final uriData = Uri.parse(this);
    //print("queryParams: ${uriData.queryParameters} path: ${uriData.path}");

    return RoutingData(
        queryParameters: uriData.queryParameters, route: uriData.path);
  }
}
