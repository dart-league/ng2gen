import 'package:dev_string_converter/dev_string_converter.dart';
import "utils.dart";

ConfigFile config = new ConfigFile();

main(List<String> args) async {

  var name = args[0];
  String lib;
  String path = ".";

  if (config?.directivesPath != null) {
    path = "${config.directivesPath}";
    lib = "lib/directives.dart";
  }

  String prefix =  config?.directivesPath != null ? "lib/" : "";

  String dartPath = '$prefix$path/${toTableName(name)}.dart';

  await writeInFile(dartPath, directiveTemplate(name));

  if (lib != null) {
    addToLibrary("$path/${toTableName(name)}.dart", lib);
  }

}

String directiveTemplate(String name) => '''
import "package:angular2/core.dart";

@Directive(
    selector: '[${toPolyName(name)}]'
)
class ${toUpperCamelCase(name)} {

  ${toUpperCamelCase(name)}();

}
''';
