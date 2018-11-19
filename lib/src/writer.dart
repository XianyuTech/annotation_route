import 'package:mustache4dart/mustache4dart.dart';
import 'collector.dart';
import 'page_config_map_util.dart';

const String clazzTpl = """
import 'dart:convert';
import 'package:annotation_route/route.dart';
{{#refs}}
import '{{{path}}}';
{{/refs}}

class \$RouterInternal<T extends \$RouteOption> {
  \$RouterInternal();
  final Map<String, List<Map<String, dynamic>>> \$innerRouterMap = {{{routerMap}}};
  dynamic instanceFromClazz(Type clazz, dynamic option) {
    {{{instanceFromClazz}}}
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
    var pageConfigList = \$innerRouterMap[option.urlpattern];
    if (null != pageConfigList) {
      for (int i = 0; i < pageConfigList.length; i++) {
        var pageConfig = pageConfigList[i];
        String paramsString = pageConfig['params'];
        if (null != paramsString) {
          Map<String, dynamic> params = null;
          try {
            params = json.decode(paramsString);
          } catch (e) {
            print('not found \${pageConfig};');
          }
          if (null != params) {
            bool match = true;
            params.forEach((k, dynamic v) {
              if (params[k] != option?.params[k]) {
                match = false;
                print('not match:\${params[k]}:\${option?.params[k]}');
              }
            });
            if (match) {
              print('matched');
              return implFromPageConfig(pageConfig, option);
            }
          } else {
            print('ERROR: in parsing params\${pageConfig}');
          }
        } else {
          return implFromPageConfig(pageConfig, option);
        }
      }
    }
    return null;
  }
}
""";

class Writer {
  Collector collector;
  Writer(this.collector);

  String instanceFromClazz() {
    final StringBuffer buffer = new StringBuffer();
    buffer..writeln('switch(clazz) {');
    final Map<String, bool> mappedClazz = <String, bool>{};
    final Function writeClazzCase = (Map<String, dynamic> config) {
      final dynamic clazz = config[wK('clazz')];
      if (mappedClazz[clazz] == null) {
        mappedClazz[clazz] = true;
      } else {
        return;
      }
      buffer.writeln('case ${clazz}: return new ${clazz}(option);');
    };
    collector.routerMap
        .forEach((String url, List<Map<String, dynamic>> configList) {
      configList.forEach(writeClazzCase);
    });
    buffer..writeln('default:return null;')..writeln('}');
    return buffer.toString();
  }

  String write() {
    final List<Map<String, String>> refs = <Map<String, String>>[];
    final Function addRef = (String path) {
      refs.add(<String, String>{'path': path});
    };
    collector.importList.forEach(addRef);
    return render(clazzTpl, <String, dynamic>{
      'refs': refs,
      'instanceFromClazz': instanceFromClazz(),
      'routerMap': collector.routerMap.toString()
    });
  }
}
