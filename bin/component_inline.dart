import 'package:dev_string_converter/dev_string_converter.dart';
import "utils.dart";
import 'package:ng2gen/ng2gen_configs.dart';

Ng2GenConfigs config = new Ng2GenConfigs();

main(List<String> args) async {

  var name = args[0];
  String lib;
  String path = "${toTableName(name)}";

  if (config?.componentsPath != null) {
    path = "${config.componentsPath}/${toTableName(name)}";
    lib = "lib/components.dart";
  }

  String prefix =  config?.componentsPath != null ? "lib/" : "";
  String filePath = '$prefix$path/${toTableName(name)}';

  String dartPath = '$filePath.dart';
  String cssPath = '$filePath.${config.cssExtension}';

  await writeInFile(dartPath, componentTemplateDart(name));
  await createFile(cssPath);

  if (lib != null) {
    addToLibrary("$path/${toTableName(name)}.dart", lib);
  }

}

String componentTemplateDart(String name) =>
    '''import 'package:angular2/core.dart';

@Component(
  selector: '${toPolyName(name)}',
  template: \'\'\'
        <p>
          ${toPolyName(name)} works!
        </p>
        \'\'\',
  styleUrls: const <String>['${toTableName(name)}.css'])
class ${toUpperCamelCase(name)} implements OnInit {

  ${toUpperCamelCase(name)}();

  @override
  void ngOnInit() {}

}
''';