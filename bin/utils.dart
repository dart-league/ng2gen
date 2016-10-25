import "dart:io";
import "dart:async";
import "package:dart_style/dart_style.dart";

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