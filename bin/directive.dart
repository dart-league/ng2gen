import 'package:dev_string_converter/dev_string_converter.dart';
import "utils.dart";

ConfigFile config = new ConfigFile();

main(List<String> args) async {

  var name = args[0];
  String lib;
  String path = ".";

  if (config?.directivesPath != null) {
    path = "${config.directivesPath}";
    lib = "${config.directivesPath}/directives.dart";
  }

  String dartPath = '$path/${toTableName(name)}_directive.dart';

  await writeInFile(dartPath, directiveTemplate(name));

  if (lib != null) {
    addToLibrary("${toTableName(name)}_directive.dart", lib);
  }

}

String directiveTemplate(String name) => '''
// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import "package:angular2/core.dart";

@Directive(
    selector: '[${toPolyName(name)}]'
)
class ${toUpperCamelCase(name)} {

  ${toUpperCamelCase(name)}() {}

}
''';
