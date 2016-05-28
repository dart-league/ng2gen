import 'dart:async';
/**
 * Created by lejard_h on 06/05/16.
 */

import "dart:io";

import "package:dev_string_converter/dev_string_converter.dart";
import "package:stagehand/src/common.dart";
import "package:stagehand/stagehand.dart";

import "app_template_data.dart" as template;
import "utils.dart";

Future createFile(String filePath, List<int> contents) {
  File file = new File(filePath);
  output('\t$filePath', Color.white);
  output(' created\n', Color.green);
  return file
      .create(recursive: true)
      .then((_) => file.writeAsBytes(contents));
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
  }

  Future generateProject() {
    Map vars = {
      'projectName': projectName
    };

    return Future.forEach(files, (TemplateFile file) {
      var resultFile = file.runSubstitution(vars);
      String filePath = resultFile.path;
      return createFile(filePath, resultFile.content);
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
}

main(List<String> args) async {
  var name = toTableName(args[0]);

  await generateApplication(name);
  await pubGet();

  output('Hint: grind --help\n', Color.gray);

  return 0;
}