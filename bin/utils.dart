import "dart:async";
import "dart:io";

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

class Color {
  final int id;

  const Color(this.id);

  static const blue = const Color(34),
      red = const Color(31),
      yellow = const Color(33),
      gray = const Color(90),
      green = const Color(32),
      white = const Color(0);

}

String _colorize(String input, Color color) {
  return '\u001b[${color.id}m$input\u001b[39m';
}

void output(String input, Color color) {
  if (Platform.isWindows) stdout.write(input);
  stdout.write(_colorize(input, color));
}

addToLibrary(String name, String libPath) {
  File lib = new File(libPath);
  if (!lib.existsSync()) {
    throw "Library at $libPath does not exist";
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