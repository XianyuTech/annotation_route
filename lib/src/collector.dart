import 'dart:convert' hide JsonDecoder;

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'page_config_map_util.dart';

class Collector {
  Collector();
  Map<String, List<Map<String, dynamic>>> routerMap =
      <String, List<Map<String, dynamic>>>{};
  List<String> importList = <String>[];

  Map<String, DartObject> toStringDartObjectMap(
      Map<DartObject, DartObject> map) {
    return map.map((DartObject k, DartObject v) {
      return MapEntry<String, DartObject>(k.toStringValue(), v);
    });
  }

  Map<String, String> toStringStringMap(Map<DartObject, DartObject> map) {
    return map.map((DartObject k, DartObject v) {
      return MapEntry<String, String>(k.toStringValue(), v.toStringValue());
    });
  }

  void collect(
      ClassElement element, ConstantReader annotation, BuildStep buildStep) {
    final String className = element.name;
    final String url = annotation.peek('url')?.stringValue;
    if (url != null) {
      addEntryFromPageConfig(annotation, className);
    }
    final ConstantReader alias = annotation.peek('alias');
    if (alias != null) {
      final List<DartObject> aliasList = alias.listValue;
      final Function addEntry = (DartObject one) {
        final ConstantReader oneObj = ConstantReader(one);
        addEntryFromPageConfig(oneObj, className);
      };
      aliasList.forEach(addEntry);
    }

    if (buildStep.inputId.path.contains('lib/')) {
      print(buildStep.inputId.path);
      importClazz(
          "package:${buildStep.inputId.package}/${buildStep.inputId.path.replaceFirst('lib/', '')}");
    } else {
      importClazz("${buildStep.inputId.path}");
    }
  }

  void addEntryFromPageConfig(ConstantReader reader, String className) {
    final String url = reader.peek('url')?.stringValue;
    if (url != null) {
      final Map<String, dynamic> map =
          genPageConfigFromConstantReader(reader, className);
      if (map != null) {
        addEntry("'${url}'", map);
      }
    }
  }

  Map<String, dynamic> genPageConfigFromConstantReader(
      ConstantReader reader, String className) {
    final ConstantReader params = reader.peek('params');
    final Map<String, dynamic> map = <String, dynamic>{wK('clazz'): className};
    if (params != null) {
      final Map<String, String> paramsMap = toStringStringMap(params.mapValue);
      map[wK('params')] = "${wK(json.encode(paramsMap))}";
    }
    return map;
  }

  void addEntry(String key, Map<String, dynamic> value) {
    List<Map<String, dynamic>> list = routerMap[key];
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
