import 'collector.dart';
import 'package:mustache4dart/mustache4dart.dart';
import 'page_config_map_util.dart';

const clazzTpl = """
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
    var clazz = pageConfig['clazz'] as Type;
    if (null == clazz) {
      return null;
    }
    try {
      var clazzInstance = instanceFromClazz(clazz, option);
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

class InnerWriter {
  write() {}
}

class OuterWriter {
  List<InnerWriter> innerWriters;
  OuterWriter(this.innerWriters);
  write() {}
}

class ImportWriter {}

class Writer {
  Collector collector;
  Writer(this.collector);

  instanceFromClazz() {
    var buffer = new StringBuffer();
    buffer..writeln("switch(clazz) {");
    var mappedClazz = <String, bool>{};
    collector.routerMap.forEach((url, configList) {
      configList.forEach((config) {
        dynamic clazz = config[wK('clazz')];
        if (mappedClazz[clazz] == null) {
          mappedClazz[clazz] = true;
        } else {
          return;
        }
        buffer.writeln("case ${clazz}: return new ${clazz}(option);");
      });
    });
    buffer..writeln("default:return null;")..writeln("}");
    return buffer.toString();
  }

  write() {
    var refs = [];
    collector.importList.forEach((path) {
      refs.add({'path': path});
    });
    return render(clazzTpl, {
      'refs': refs,
      'instanceFromClazz': instanceFromClazz(),
      'routerMap': collector.routerMap.toString()
    });
  }
}
