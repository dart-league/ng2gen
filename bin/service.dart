import 'dart:io';
import 'package:dev_string_converter/dev_string_converter.dart';

main(List<String> args) async {
//  await new Directory('${args[0]}').create();
  var name = args[0];
  (await new File('${name}.dart').create()).writeAsString(
      '''// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Injectable()
class ${toUpperCamelCase(name)} {

}
''');
}
