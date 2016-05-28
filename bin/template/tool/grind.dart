import "dart:io";
import "package:grinder/grinder.dart";
import 'package:ng2gen/ng2gen_configs.dart';

Ng2GenConfigs config = new Ng2GenConfigs();

main(List<String> args) async => await grind(args);

@Task("serve")
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
@Depends(test, doc, build)
deploy() async {}

@Task("clean")
void clean() => defaultClean();