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
    lib = "${config.componentsPath}/components.dart";
  }

  String dartPath = '$path/${toTableName(name)}_component.dart';
  String htmlPath = '$path/${toTableName(name)}_component.html';
  String cssPath = '$path/${toTableName(name)}_component.css';

  await writeInFile(dartPath, componentTemplateDart(name));
  await writeInFile(htmlPath, componentTemplateHtml(name));
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
  templateUrl: '${toTableName(name)}_component.html',
  styleUrls: const ['${toTableName(name)}_component.css'])
class ${toUpperCamelCase(name)} implements OnInit {

  ${toUpperCamelCase(name)}();

  ngOnInit() {}

}
''';

String componentTemplateHtml(String name) => '''
<p>
  ${toPolyName(name)} works!
</p>
''';