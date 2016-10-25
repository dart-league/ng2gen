import 'package:dev_string_converter/dev_string_converter.dart';
import "utils.dart";
import 'package:ng2gen/ng2gen_configs.dart';

Ng2GenConfigs config = new Ng2GenConfigs();

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
