import 'package:dev_string_converter/dev_string_converter.dart';
import "utils.dart";

ConfigFile config = new ConfigFile();

main(List<String> args) async {

  var name = args[0];
  String lib;
  String path = "${toTableName(name)}";

  if (config?.componentsPath != null) {
    path = "${config.componentsPath}/${toTableName(name)}";
    lib = "${config.componentsPath}/components.dart";
  }

  String dartPath = '$path/${toTableName(name)}_component.dart';
  String cssPath = '$path/${toTableName(name)}_component.css';

  await writeInFile(dartPath, componentTemplateDart(name));
  await createFile(cssPath);

  if (lib != null) {
    addToLibrary("${toTableName(name)}/${toTableName(name)}_component.dart", lib);
  }

}

String componentTemplateDart(String name) =>
    '''// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

@Component(
  selector: '${toPolyName(name)}',
  template: \'\'\'
        <p>
          ${toPolyName(name)} works!
        </p>
        \'\'\',
  styleUrls: const ['${toTableName(name)}_component.css'])
class ${toUpperCamelCase(name)} implements OnInit {

  ${toUpperCamelCase(name)}() {}

  ngOnInit() {}

}
''';