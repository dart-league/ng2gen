import 'dart:io';
import 'package:yaml/yaml.dart';
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
  root: "app.dart"
  components: "lib/components"
  directives: "lib/directives"
  services: "lib/services"
  routes: "lib/routes"
  pipes: "lib/pipes"
  sass: false
  less: false
server:
  hostname: "0.0.0.0"
  port: 1337''';
