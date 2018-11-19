// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteWriterGenerator
// **************************************************************************

import 'dart:convert';
import 'package:annotation_route/route.dart';
import 'package:annotation_route/example/page_a.dart';
import 'package:annotation_route/example/page_d.dart';
import 'package:annotation_route/example/page_b.dart';
import 'package:annotation_route/example/page_c.dart';

class $RouterInternal<T extends $RouteOption> {
  $RouterInternal();
  final Map<String, List<Map<String, dynamic>>> $innerRouterMap = {
    'myapp://pagea': [
      {'clazz': A}
    ],
    'myapp://paged': [
      {'clazz': D, 'params': '{"parama":"d"}'}
    ],
    'myapp://pageb': [
      {'clazz': B, 'params': '{"parama":"b"}'}
    ],
    'myapp://pagec': [
      {'clazz': C}
    ],
    'myapp://pagec_alias': [
      {'clazz': C}
    ]
  };
  dynamic instanceFromClazz(Type clazz, dynamic option) {
    switch (clazz) {
      case A:
        return new A(option);
      case D:
        return new D(option);
      case B:
        return new B(option);
      case C:
        return new C(option);
      default:
        return null;
    }
  }

  dynamic implFromPageConfig(Map<String, dynamic> pageConfig, T option) {
    final Type clazz = pageConfig['clazz'];
    if (null == clazz) {
      return null;
    }
    try {
      final dynamic clazzInstance = instanceFromClazz(clazz, option);
      return clazzInstance;
    } catch (e) {
      return null;
    }
  }

  dynamic implFromRouteOption(T option) {
    var pageConfigList = $innerRouterMap[option.urlpattern];
    if (null != pageConfigList) {
      for (int i = 0; i < pageConfigList.length; i++) {
        var pageConfig = pageConfigList[i];
        String paramsString = pageConfig['params'];
        if (null != paramsString) {
          Map<String, dynamic> params = null;
          try {
            params = json.decode(paramsString);
          } catch (e) {
            print('not found ${pageConfig};');
          }
          if (null != params) {
            bool match = true;
            params.forEach((k, dynamic v) {
              if (params[k] != option?.params[k]) {
                match = false;
                print('not match:${params[k]}:${option?.params[k]}');
              }
            });
            if (match) {
              print('matched');
              return implFromPageConfig(pageConfig, option);
            }
          } else {
            print('ERROR: in parsing params${pageConfig}');
          }
        } else {
          return implFromPageConfig(pageConfig, option);
        }
      }
    }
    return null;
  }
}
