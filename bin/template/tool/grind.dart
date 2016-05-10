import "dart:io";
import "package:grinder/grinder.dart";
import "package:yaml/yaml.dart";
import "package:dogma_codegen/build.dart" as dogma_build;
import "package:watcher/watcher.dart";

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

  String get projectName {
    if (_config?.containsKey("project")) {
      return _config["project"]["name"];
    }
    return null;
  }

  int get serverPort {
    if (_config?.containsKey("server")) {
      return _config["server"]["port"];
    }
    return null;
  }

  String get serverHostname {
    if (_config?.containsKey("server")) {
      return _config["server"]["hostname"];
    }
    return null;
  }

  String get componentsPath {
    if (_config?.containsKey("project")) {
      return _config["project"]["components"];
    }
    return null;
  }

  String get servicesPath {
    if (_config?.containsKey("project")) {
      return _config["project"]["services"];
    }
    return null;
  }

  String get pipesPath {
    if (_config?.containsKey("project")) {
      return _config["project"]["pipes"];
    }
    return null;
  }

  String get routesPath {
    if (_config?.containsKey("project")) {
      return _config["project"]["routes"];
    }
    return null;
  }

  String get directivesPath {
    if (_config?.containsKey("project")) {
      return _config["project"]["directives"];
    }
    return null;
  }

  String get modelsPath {
    if (_config?.containsKey("project")) {
      return _config["project"]["models"];
    }
    return null;
  }
}

ConfigFile config = new ConfigFile();

main(List<String> args) async => await grind(args);

@Task("models")
codegen() async {
  await dogma_build.build([],
      modelLibrary: "lib/models.dart",
      modelPath: "lib/models/",
      convertPath: "lib/convert",
      convertLibrary: "lib/convert/convert.dart",
      mapper: false,
      unmodifiable: false);
}

@Task("watchModels")
watchModels() {
  new Watcher("lib/models").events.listen((WatchEvent _) {
    print("[codegen]");
    codegen();
  });
}

@Task("serve")
@Depends(codegen, watchModels)
serve() async {
  Process _server = await Process.start(
      "pub",
      [
        "serve",
        "--hostname=${config.serverHostname}",
        "--port=${config.serverPort}"
      ],
      runInShell: true);
  print("Serving http://${config.serverHostname}:${config.serverPort}");

  Process dartium;

  _server.stdout.listen((List<int> data) async {
    String message = new String.fromCharCodes(data);
    stdout.write(message);
    if (message == "Build completed successfully\n" && dartium == null) {
      dartium = await Process.start(
          "dartium", ["http://${config.serverHostname}:${config.serverPort}"],
          runInShell: true);
    }
  });

  _server.stderr.listen((List<int> data) {
    stderr.write(new String.fromCharCodes(data));
  });
  await _server.exitCode;
}

@Task("doc")
doc() {
  DartDoc.doc();
}

@Task("build")
build() async {
  Process p = await Process.start("pub", ["build", "--mode=release", "-DPRODUCTION=true"]);
  p.stdout.listen((List<int> data) async {
    stdout.write(new String.fromCharCodes(data));
  });
  p.stderr.listen((List<int> data) {
    stderr.write(new String.fromCharCodes(data));
  });
  await p.exitCode;
}

@Task("test")
test() {
  new PubApp.local('test').run([]);
}

@Task("deploy")
@Depends(test, doc, codegen, build)
deploy() async {}

@Task("clean")
void clean() => defaultClean();