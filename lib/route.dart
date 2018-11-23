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

class ARouteOption {
  String urlpattern;
  Map<String, dynamic> params;
  ARouteOption(this.urlpattern, this.params);
}

enum ARouterResultState { FOUND, REDIRECT, NOT_FOUND }

class ARouterResult {
  dynamic widget;
  String interceptor;
  ARouterResultState state;
  ARouterResult({this.state, this.widget, this.interceptor});
}

abstract class ARouterInternal {
  bool hasPageConfig(ARouteOption option);
  ARouterResult findPage(ARouteOption option, dynamic initOption);
}
