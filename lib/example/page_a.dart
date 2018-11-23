import 'package:annotation_route/route.dart';

@ARoute(url: 'myapp://pagea')
class A {
  int a;
  String b;
  A(ARouteOption option) : super();
}
