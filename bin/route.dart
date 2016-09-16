import "dart:io";

import 'package:dev_string_converter/dev_string_converter.dart';

import "utils.dart";
import "component.dart";

ConfigFile config = new ConfigFile();

main(List<String> args) async {

    String name = "${args[0]}-route";
    String lib;
    String path = "${toTableName(name)}";
    String routePath = args[1];

    if (config?.routesPath != null) {
        path = "${config.routesPath}/${toTableName(name)}";
        lib = "lib/routes.dart";
    }

    String prefix =  config?.routesPath != null ? "lib/" : "";

    String dartPath = '$prefix$path/${toTableName(name)}_component.dart';
    String htmlPath = '$prefix$path/${toTableName(name)}_component.html';
    String cssPath = '$prefix$path/${toTableName(name)}_component.css';

    await writeInFile(dartPath, componentRouteTemplateDart(name, routePath));
    await writeInFile(htmlPath, componentTemplateHtml(name));
    await createFile(cssPath);

    if (lib != null) {
        addToLibrary("$path/${toTableName(name)}_component.dart", lib);
        addToRouteConfig(toUpperCamelCase(name), config?.rootPath);
    }
}

String componentRouteTemplateDart(String name, String path) =>
    '''// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
@Component(
  selector: '${toPolyName(name)}',
  templateUrl: '${toTableName(name)}_component.html',
  styleUrls: const ['${toTableName(name)}_component.css'])
class ${toUpperCamelCase(name)} implements OnInit {

  static const String route_name = "${toUpperCamelCase(name)}";
  static const String route_path = "$path";

  ${toUpperCamelCase(name)}();

  ngOnInit() {}

}
''';

addToRouteConfig(String className, String rootPath) {
    File rootComponent = new File("lib/$rootPath/app.dart");

    if (rootComponent.existsSync()) {
        String content = rootComponent.readAsStringSync();
        content = formatter.format(content);
        content = content.replaceFirst("@RouteConfig(const [", '''
        @RouteConfig(const [
            const Route(useAsDefault: false, path: $className.route_path, name: $className.route_name, component: $className),
        ''');
        rootComponent.writeAsStringSync(formatter.format(content));
    }
}