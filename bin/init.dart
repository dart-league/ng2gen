import 'dart:io';
import 'package:ng2gen/ng2gen_configs.dart';
import 'package:yaml/yaml.dart';
import 'package:yamlicious/yamlicious.dart';
import "utils.dart";

main(List<String> _) async {
  File pubspec = new File("pubspec.yaml");
  if (!(await pubspec.exists())) {
    output("'pubspec.yaml' not found.\n", Color.red);
  } else {
    File config = new File(config_file_name);
    if (config.existsSync()) {
      output("'$config_file_name' already exist.\n", Color.red);
    } else {
      config.writeAsString(toYamlString(new YamlMap.wrap(Ng2GenConfigs.defaultConfigYaml)));
    }
  }
}
