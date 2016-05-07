import 'package:dev_string_converter/dev_string_converter.dart';
import "utils.dart";

ConfigFile config = new ConfigFile();

main(List<String> args) async {

  var name = args[0];
  String lib;
  String path = ".";

  if (config?.pipesPath != null) {
    path = "${config.pipesPath}";
    lib = "${config.pipesPath}/pipes.dart";
  }

  String dartPath = '$path/${toTableName(name)}_pipe.dart';

  await writeInFile(dartPath, pipeTemplate(name));

  if (lib != null) {
    addToLibrary("${toTableName(name)}_pipe.dart", lib);
  }

}

String pipeTemplate(String name) => '''
// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import "package:angular2/core.dart";

@Pipe(
  name: '${toUpperCamelCase(name)}'
)
@Injectable()
class ${toUpperCamelCase(name)} implements PipeTransform {

  const ${toUpperCamelCase(name)}();

  dynamic transform(dynamic value, [List<dynamic> args = null]) {
    return value;
  }

}

''';
