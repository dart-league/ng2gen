import 'package:dev_string_converter/dev_string_converter.dart';
import "utils.dart";
import 'package:ng2gen/ng2gen_configs.dart';

Ng2GenConfigs config = new Ng2GenConfigs();

main(List<String> args) async {

  var name = args[0];
  String lib;
  String path = ".";

  if (config?.servicesPath != null) {
    path = "${config.servicesPath}";
    lib = "${config.servicesPath}/services.dart";
  }

  String dartPath = '$path/${toTableName(name)}_service.dart';

  await writeInFile(dartPath, serviceTemplate(name));

  if (lib != null) {
    addToLibrary("${toTableName(name)}_service.dart", lib);
  }

}

String serviceTemplate(String name) =>
    '''// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import "package:angular2/core.dart";

@Injectable()
class ${toUpperCamelCase(name)}Service {

  ${toUpperCamelCase(name)}Service();

}
''';
