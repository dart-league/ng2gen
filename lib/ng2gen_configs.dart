import 'dart:io';
import 'package:yaml/yaml.dart';

const String config_file_name = "generator.config.yaml";

class Ng2GenConfigs {

  static Map _config;

  Ng2GenConfigs() {
    if (_config == null) {
      File _configFile = new File(config_file_name);
      if (_configFile.existsSync()) {
        _config = loadYaml(_configFile.readAsStringSync());
      }
    }
  }

  _getConfig(String configName) =>
      (_config != null && _config.containsKey("project"))
          ?  _config["project"][configName]
          : null;

  String get projectName => _getConfig('name');

  int get serverPort => _getConfig("port");

  String get serverHostname => _getConfig("hostname");

  String get componentsPath => _getConfig("components");

  String get servicesPath => _getConfig("services");

  String get pipesPath  => _getConfig("pipes");

  String get routesPath  => _getConfig("routes");

  String get directivesPath  => _getConfig("directives");

  String get modelsPath => _getConfig("models");

  String get rootPath => _getConfig("root");

  String get styleFileType {
    if (_getConfig('useSass') == true) {
      return "scss";
    } else if (_getConfig('useLess') == true) {
      return "less";
    }
    return "css";
  }

}
