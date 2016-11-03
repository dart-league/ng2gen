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
      (_config != null && _config.containsKey("project")) ? _config["project"][configName] : null;

  String get projectName => _getConfig('name');

  int get serverPort => _getConfig("port");

  String get serverHostname => _getConfig("hostname");

  String get componentsPath => _getConfig("components");

  String get servicesPath => _getConfig("services");

  String get pipesPath => _getConfig("pipes");

  String get routesPath => _getConfig("routes");

  String get directivesPath => _getConfig("directives");

  String get rootPath => _getConfig("root");

  String get cssExtension => _getConfig("css_extension") ?? "css";

  String get htmlExtension => _getConfig("html_extension") ?? "html";

  static Map<String, dynamic> get defaultConfigYaml => <String, dynamic>{
    "project": <String, dynamic>{
      "root": "app.dart",
      "components": "components",
      "directives": "directives",
      "services": "services",
      "routes": "routes",
      "pipes": "pipes",
      "css_extension": "css",
      "html_extension": "html",
    }
  };
}
