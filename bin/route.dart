import "dart:io";

import 'package:dev_string_converter/dev_string_converter.dart';

import 'package:ng2gen/ng2gen_configs.dart';
import "utils.dart";
import "component.dart";

Ng2GenConfigs config = new Ng2GenConfigs();

main(List<String> args) async {
  String name = args[0];
  String routePath = args[1];
  String lib;
  String path = "${toTableName(name)}";

  if (config?.routesPath != null) {
    path = "${config.routesPath}/${toTableName(name)}";
    lib = "lib/routes.dart";
  }

  String prefix = config?.routesPath != null ? "lib/" : "";
  String filePath = '$prefix$path/${toTableName(name)}';

  String dartPath = '$filePath.dart';
  String htmlPath = '$filePath.${config.htmlExtension}';
  String cssPath = '$filePath.${config.cssExtension}';

  await writeInFile(dartPath, componentRouteTemplateDart(name, routePath));
  await writeInFile(htmlPath, componentTemplateHtml(name));
  await createFile(cssPath);

  if (lib != null) {
    addToLibrary("$path/${toTableName(name)}.dart", lib);
    addToRouteConfig(toUpperCamelCase(name), config?.rootPath);
  }
}

String componentRouteTemplateDart(String name, String path) => '''import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
  selector: '${name.replaceAll("_", "-")}',
  templateUrl: '${toTableName(name)}.html',
  styleUrls: const <String>['${toTableName(name)}.css'])
class ${toUpperCamelCase(name)} implements OnInit {

  static const String route_name = "${toUpperCamelCase(name)}";
  static const String route_path = "$path";
  static const Route route = const Route(path: ${toUpperCamelCase(name)}.route_path,
      component: ${toUpperCamelCase(name)},
      name: ${toUpperCamelCase(name)}.route_name);

  ${toUpperCamelCase(name)}();

  @override
  void ngOnInit() {}

}
''';

addToRouteConfig(String className, String rootPath) {
  File rootComponent = new File("lib/$rootPath");

  if (rootComponent.existsSync()) {
    String content = rootComponent.readAsStringSync();
    content = formatter.format(content);
    content = content.replaceFirst(
        "/*Insert Routes here*/",
        '''
            /*Insert Routes here*/
            $className.route,
        ''');
    rootComponent.writeAsStringSync(formatter.format(content));
    output("Route Inserted into root component.\n", Color.yellow);
  }
}
