import 'dart:io';
import 'package:yaml/yaml.dart';

class Ng2GenConfigs {

  static Map _config;

  Ng2GenConfigs() {
    if (_config == null) {
      File _configFile = new File("generator.config.yaml");
      if (_configFile.existsSync()) {
        _config = loadYaml(_configFile.readAsStringSync());
      }
    }
  }

  String get projectName {
    if (_config != null && _config.containsKey("project")) {
      return _config["project"]["name"];
    }
    return null;
  }

  int get serverPort {
    if (_config != null && _config.containsKey("server")) {
      return _config["server"]["port"];
    }
    return null;
  }

  String get serverHostname {
    if (_config != null && _config.containsKey("server")) {
      return _config["server"]["hostname"];
    }
    return null;
  }

  String get componentsPath {
    if (_config != null &&_config.containsKey("project")) {
      return _config["project"]["components"];
    }
    return null;
  }

  String get servicesPath {
    if (_config != null && _config.containsKey("project")) {
      return _config["project"]["services"];
    }
    return null;
  }

  String get pipesPath {
    if (_config != null && _config.containsKey("project")) {
      return _config["project"]["pipes"];
    }
    return null;
  }

  String get routesPath {
    if (_config != null && _config.containsKey("project")) {
      return _config["project"]["routes"];
    }
    return null;
  }

  String get directivesPath {
    if (_config != null && _config.containsKey("project")) {
      return _config["project"]["directives"];
    }
    return null;
  }

  String get modelsPath {
    if (_config != null && _config.containsKey("project")) {
      return _config["project"]["models"];
    }
    return null;
  }

}
