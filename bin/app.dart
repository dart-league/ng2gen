/**
 * Created by lejard_h on 06/05/16.
 */

import "dart:io";
import 'dart:async';

import "package:dev_string_converter/dev_string_converter.dart";
import "utils.dart";
import "package:stagehand/stagehand.dart";
import "package:stagehand/src/common.dart";
import "app_template_data.dart" as template;
import 'package:path/path.dart' as path;

class _DirectoryGeneratorTarget extends GeneratorTarget {
  final Directory dir;

  _DirectoryGeneratorTarget(this.dir) {
    dir.createSync();
  }

  Future createFile(String filePath, List<int> contents) {
    File file = new File(path.join(dir.path, filePath));
    output('\t$filePath', Color.white);
    output(' created\n', Color.green);
    return file
        .create(recursive: true)
        .then((_) => file.writeAsBytes(contents));
  }
}


class Angular2Gen extends DefaultGenerator {
  String projectName;
  GeneratorTarget target;

   Angular2Gen(this.projectName)
        : super('ng2gen', 'Angular 2 Web Application',
        'A web app built using Angular 2.') {

     for (TemplateFile file in decodeConcatenatedData(template.data)) {
       addTemplateFile(file);
     }

     target = new _DirectoryGeneratorTarget(new Directory(projectName));
    }

   Future generateProject() {
     Map vars = {
       'projectName': projectName
     };

     return Future.forEach(files, (TemplateFile file) {
       var resultFile = file.runSubstitution(vars);
       String filePath = resultFile.path;
       return target.createFile(filePath, resultFile.content);
     });
   }

    String getInstallInstructions() => "Hint: cd $projectName &&  grind --help";
}


pubGet() async {
  output('Running Pub Get', Color.green);
  progress();

  try {
    await Process.run('pub', ['get']);
  } catch (e) {
    output('\n••• Couldn\'t run pub get', Color.red);
  }

  endProgress();
}

generateApplication(String name) async {
  output("Creating $name application\n", Color.green);
  progress();
  Angular2Gen generator = new Angular2Gen(name);
  await generator.generateProject();
  endProgress();
  Directory.current = name;
}

main(List<String> args) async {
    var name = toTableName(args[0]);

    await generateApplication(name);
    await pubGet();

    output('Hint: cd $name &&  grind --help\n', Color.gray);

    return 0;
}