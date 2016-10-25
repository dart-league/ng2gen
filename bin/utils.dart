import "dart:io";
import "dart:async";
import "package:dart_style/dart_style.dart";
import "package:yaml/yaml.dart";

const String config_file_name = "angular.config.yaml";

Future<File> createFile(String path) async {
  File file = new File(path);
  if (!file.existsSync()) {
    await file.create(recursive: true);
  }
  if (file.existsSync()) {
    output("'$path' file created.\n", Color.green);
  } else {
    output("Fail to create '$path' file.\n", Color.red);
    throw "Impossible to create file $path";
  }
  return file;
}

DartFormatter formatter = new DartFormatter();

writeInDartFile(String path, String content) async =>
    writeInFile(path, formatter.format(content));

writeInFile(String path, String content) async {
  File fileDart = await createFile(path);
  await fileDart.writeAsString(content);
  return fileDart;
}

enum Color { blue, red, yellow, gray, green, white }

int _colorId(Color color) => {
  Color.blue: 34,
  Color.red: 31,
  Color.yellow: 33,
  Color.gray: 90,
  Color.green: 32,
  Color.white: 0
}[color];

String _colorize(String input, Color color) {
  return '\u001b[${_colorId(color)}m$input\u001b[39m';
}

void output(String input, Color color) {
  if (Platform.isWindows) stdout.write(input);
  stdout.write(_colorize(input, color));
}

addToLibrary(String name, String libPath) {
  File lib = new File(libPath);
  if (!lib.existsSync()) {
    output("Creating library '$libPath'.\n", Color.gray);
  }

  lib.writeAsStringSync(
      "export '$name';\n",
      mode: FileMode.APPEND);
  output("Add to library '$libPath'.\n", Color.yellow);
}

class ConfigFile {

  static Map _config;

  ConfigFile() {
    if (_config == null) {
      File _configFile = new File("angular.config.yaml");
      if (_configFile.existsSync()) {
        _config = loadYaml(_configFile.readAsStringSync());
      }
    }
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

  bool get useSass {
    if (_config != null &&_config.containsKey("project")) {
      return _config["project"]["sass"];
    }
    return null;
  }

  bool get useLess {
    if (_config != null &&_config.containsKey("project")) {
      return _config["project"]["less"];
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

  String get rootPath {
    if (_config != null && _config.containsKey("project")) {
      return _config["project"]["root"];
    }
    return null;
  }

  String get styleFileType {
    if (useSass == true) {
      return "scss";
    } else if (useLess == true) {
      return "less";
    }
    return "css";
  }

}

StreamSubscription _progressSubscription;

void progress() {
  _progressSubscription =
      new Stream.periodic(const Duration(seconds: 1)).listen((_) {
        output('.', Color.white);
      });
}

void endProgress() {
  _progressSubscription.cancel();
  stdout.write('\n');
}