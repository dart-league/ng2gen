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
    lib = config.useRoutesFile ? "lib/routes.dart" : null;
  }

  String prefix = config?.routesPath != null ? "lib/" : "";
  String filePath = '$prefix$path/${toTableName(name)}';

  String dartPath = '$filePath.dart';
  String htmlPath = '$filePath.${config.htmlExtension}';
  String cssPath = '$filePath.${config.cssExtension}';

  await writeInFile(dartPath, componentRouteTemplateDart(name));
  await writeInFile(htmlPath, componentTemplateHtml(name));
  await createFile(cssPath);

  if (lib != null) {
    addToLibrary("$path/${toTableName(name)}.dart", lib);
  }
  addToRouteConfig(toUpperCamelCase(name), config?.rootPath, routePath, dartPath);
}

String componentRouteTemplateDart(String name) =>
    '''import 'package:angular/angular.dart';

@Component(
  selector: '${name.replaceAll("_", "-")}',
  templateUrl: '${toTableName(name)}.html',
  styleUrls: const ['${toTableName(name)}.css'])
class ${toUpperCamelCase(name)} implements OnInit {

  ${toUpperCamelCase(name)}();

  @override
  void ngOnInit() {}

}
''';

addToRouteConfig(String className, String rootPath, String routePath, String dartPath) {
  File rootComponent = new File("lib/$rootPath");

  if (rootComponent.existsSync()) {
    String content = rootComponent.readAsStringSync();
    if (!config.useRoutesFile) {
      content = "import 'package:${config.projectName}/${dartPath.replaceFirst('lib/', '')}';\n" + content;
    }
    content = content.replaceFirst(
        new RegExp(r'@RouteConfig\(const\s*\['),
        """@RouteConfig(const [
 const Route(path: '$routePath${toPolyName(className)}',
      component: $className,
      name: '$className'),""");
    rootComponent.writeAsStringSync(formatter.format(content));
    output("Route Inserted into root component.\n", Color.yellow);
  }
}
