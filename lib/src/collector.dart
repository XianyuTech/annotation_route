import 'dart:convert' hide JsonDecoder;

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'page_config_map_util.dart';

class Collector {
  Collector();
  Map<String, List<Map<String, dynamic>>> routerMap = {};
  List<String> importList = [];

  Map<String, DartObject> toStringDartObjectMap(
      Map<DartObject, DartObject> map) {
    return map.map((k, v) {
      return MapEntry(k.toStringValue(), v);
    });
  }

  Map<String, String> toStringStringMap(Map<DartObject, DartObject> map) {
    return map.map((k, v) {
      return MapEntry(k.toStringValue(), v.toStringValue());
    });
  }

  void collect(
      ClassElement element, ConstantReader annotation, BuildStep buildStep) {
    String className = element.name;
    var url = annotation.peek('url')?.stringValue;
    if (url != null) {
      addEntryFromPageConfig(annotation, className);
    }
    var alias = annotation.peek('alias');
    if (alias != null) {
      var aliasList = alias.listValue;
      aliasList.forEach((one) {
        print(one);
        var oneObj = ConstantReader(one);
        addEntryFromPageConfig(oneObj, className);
        return;
      });
    }

    if (buildStep.inputId.path.indexOf('lib/') > -1) {
      print(buildStep.inputId.path);
      importClazz(
          "package:${buildStep.inputId.package}/${buildStep.inputId.path.replaceFirst('lib/', '')}");
    } else {
      importClazz("${buildStep.inputId.path}");
    }
  }

  void addEntryFromPageConfig(ConstantReader reader, String className) {
    var url = reader.peek('url')?.stringValue;
    if (url != null) {
      var map = genPageConfigFromConstantReader(reader, className);
      if (map != null) {
        addEntry("'${url}'", map);
      }
    }
  }

  Map genPageConfigFromConstantReader(ConstantReader reader, String className) {
    var params = reader.peek('params');
    var map = {wK('clazz'): className};
    if (params != null) {
      var paramsMap = toStringStringMap(params.mapValue);
      map[wK('params')] = "${wK(json.encode(paramsMap))}";
    }
    return map;
  }

  void addEntry(String key, Map<String, dynamic> value) {
    var list = routerMap[key];
    if (null == list) {
      list = <Map<String, dynamic>>[];
      routerMap[key] = list;
    }
    list.add(value);
  }

  void importClazz(String path) {
    importList.add(path);
  }
}
