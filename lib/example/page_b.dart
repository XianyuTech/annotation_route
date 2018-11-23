import 'package:annotation_route/route.dart';

@ARoute(url: 'myapp://pageb', params: {'parama': 'b'})
class B {
  int a;
  String b;
  B(ARouteOption option) : super();
}
