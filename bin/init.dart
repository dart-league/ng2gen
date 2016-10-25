import 'dart:io';
import 'package:ng2gen/ng2gen_configs.dart';
import "utils.dart";

main(List<String> _) async {
  File pubspec = new File("pubspec.yaml");
  if (!(await pubspec.exists())) {
    output("'pubspec.yaml' not found.", Color.red);
  } else {
    File config = new File(config_file_name);
    if (config.existsSync()) {
      output("'$config_file_name' already exist.", Color.red);
    } else {
      config.writeAsString(configYaml);
    }
  }
}

String get configYaml =>
'''project:
  root: app.dart
  components: components
  directives: directives
  services: services
  routes: routes
  pipes: pipes
  sass: false
  less: false
  ''';
