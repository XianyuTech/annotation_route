/**
 * Annotation class that supports you annotate a route page with @ARoute
 */
class ARoute {
  /**
   * The description of the annotated route
   */
  final String desc;
  /**
   * Used to match a route, and will the first match condition
   */
  final String url;
  /**
   * Used to math a route
   */
  final Map<String, dynamic> params;
  /**
   * Used when a route support multiple match patterns
   */
  final List<ARouteAlias> alias;
  const ARoute({this.desc, this.url, this.params, this.alias});
}

/**
 * Annotation class that supports you annotate your own router class @ARouteRoot
 */
class ARouteRoot {
  const ARouteRoot();
}

class ARouteAlias {
  final String desc;
  final String url;
  final Map<String, dynamic> params;
  const ARouteAlias({this.desc, this.url, this.params});
}

/**
 * This represent a condition collection to match a route
 */
class ARouteOption {
  String urlpattern;
  Map<String, dynamic> params;
  ARouteOption(this.urlpattern, this.params);
}

enum ARouterResultState { FOUND, REDIRECT, NOT_FOUND }

/**
 *  The result of findPage in [ARouterInternal]
 */
class ARouterResult {
  /**
   * The annotated widget found
   */
  dynamic widget;
  /**
   * [TODO]
   */
  String interceptor;
  /**
   * The state represents a kind of result
   */
  ARouterResultState state;
  ARouterResult({this.state, this.widget, this.interceptor});
}

/**
 * The public interface to find a annotated route
 */
abstract class ARouterInternal {
  bool hasPageConfig(ARouteOption option);
  ARouterResult findPage(ARouteOption option, dynamic initOption);
}
