import 'package:annotation_route/route.dart';

@ARoute(alias: [
  ARouteAlias(url: 'myapp://paged', params: {'parama': 'd'})
])
class D {
  int a;
  String b;
  D($RouteOption option) : super();
}
