import 'package:dev_string_converter/dev_string_converter.dart';
import "utils.dart";

ConfigFile config = new ConfigFile();

main(List<String> args) async {

  var name = args[0];
  String lib;
  String path = ".";

  if (config?.pipesPath != null) {
    path = "${config.pipesPath}";
    lib = "lib/pipes.dart";
  }

  String prefix =  config?.pipesPath != null ? "lib/" : "";

  String dartPath = '$prefix$path/${toTableName(name)}.dart';

  await writeInFile(dartPath, pipeTemplate(name));

  if (lib != null) {
    addToLibrary("$path/${toTableName(name)}.dart", lib);
  }

}

String pipeTemplate(String name) => '''
import "package:angular2/core.dart";

@Pipe(
  name: '${toLowerCamelCase(name)}'
)
@Injectable()
class ${toUpperCamelCase(name)} implements PipeTransform {

  const ${toUpperCamelCase(name)}();

  @override
  dynamic transform(dynamic value, [List<dynamic> args = null]) {
    return value;
  }

}

''';
