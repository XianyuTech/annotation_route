import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import '../route.dart';
import 'collector.dart';
import 'writer.dart';

class RouteWriterGenerator extends GeneratorForAnnotation<ARouteRoot> {
  collector() {
    return RouteGenerator.collector;
  }

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return Writer(collector()).write();
  }
}

class RouteGenerator extends GeneratorForAnnotation<ARoute> {
  static Collector collector = Collector();

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    collector.collect(element, annotation, buildStep);
    return null;
  }
}
