import "dart:io";

import 'package:dev_string_converter/dev_string_converter.dart';

import "utils.dart";
import "component.dart";

ConfigFile config = new ConfigFile();

main(List<String> args) async {

    String name = "${args[0]}-route";
    String lib;
    String path = "${toTableName(name)}";

    if (config?.routesPath != null) {
        path = "${config.routesPath}/${toTableName(name)}";
        lib = "${config.routesPath}/routes.dart";
    }

    String dartPath = '$path/${toTableName(name)}_component.dart';
    String htmlPath = '$path/${toTableName(name)}_component.html';
    String cssPath = '$path/${toTableName(name)}_component.css';

    await writeInFile(dartPath, componentTemplateDart(name));
    await writeInFile(htmlPath, componentTemplateHtml(name));
    await createFile(cssPath);

    if (lib != null) {
        addToLibrary("${toTableName(name)}/${toTableName(name)}_component.dart", lib);
        addToRouteConfig(toUpperCamelCase(name), toUpperCamelCase(args[0]), args[1]);
    }

}

addToRouteConfig(String className, String name, String path) {
    File rootComponent = new File("lib/${config.projectName}.dart");

    if (rootComponent.existsSync()) {
        String content = rootComponent.readAsStringSync();
        content = formatter.format(content);
        content = content.replaceFirst("@RouteConfig(const [", '''
        @RouteConfig(const [
            const Route(useAsDefault: false, path: '$path', name: '$name', component: $className),
        ''');
        rootComponent.writeAsStringSync(formatter.format(content));
    }
}