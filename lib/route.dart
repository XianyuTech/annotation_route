class ARoute {
  final String desc;
  final String url;
  final Map<String, dynamic> params;
  final List<ARouteAlias> alias;
  const ARoute({this.desc, this.url, this.params, this.alias});
}

class ARouteRoot {
  const ARouteRoot();
}

class ARouteAlias {
  final String desc;
  final String url;
  final Map<String, dynamic> params;
  const ARouteAlias({this.desc, this.url, this.params});
}

class $RouteOption {
  String urlpattern;
  Map<String, dynamic> params;
  $RouteOption(this.urlpattern, this.params);
}
