import 'dart:io';
import 'package:yaml/yaml.dart';

const String config_file_name = "generator.config.yaml";

class Ng2GenConfigs {
  static Map _config;
  static Map _pubspec;

  Ng2GenConfigs() {
    if (_config == null) {
      File _configFile = new File(config_file_name);
      if (_configFile.existsSync()) {
        _config = loadYaml(_configFile.readAsStringSync());
        _pubspec = loadYaml(new File('pubspec.yaml').readAsStringSync());
      }
    }
  }

  _getConfig(String configName) =>
      (_config != null && _config.containsKey("project")) ? _config["project"][configName] : null;

  String get projectName => _pubspec['name'];

  String get componentsPath => _getConfig("components");

  bool get useComponentsFile => _getConfig("use_components_file") ?? false;

  String get servicesPath => _getConfig("services");

  bool get useServicesFile => _getConfig("use_services_file") ?? false;

  String get pipesPath => _getConfig("pipes");

  bool get usePipesFile => _getConfig("use_pipes_file") ?? false;

  String get routesPath => _getConfig("routes");

  bool get useRoutesFile => _getConfig("use_routes_file") ?? false;

  String get directivesPath => _getConfig("directives");

  bool get useDirectivesFile => _getConfig("use_directives_file") ?? false;

  String get rootPath => _getConfig("root");

  String get cssExtension => _getConfig("css_extension") ?? "css";

  String get htmlExtension => _getConfig("html_extension") ?? "html";

  static Map<String, dynamic> get defaultConfigYaml => <String, dynamic>{
    "project": <String, dynamic>{
      "root": "app_component.dart",
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
