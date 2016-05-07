/**
 * Created by lejard_h on 06/05/16.
 */

import "dart:io";
import 'dart:async';

import "package:dev_string_converter/dev_string_converter.dart";
import "utils.dart";


StreamSubscription _progressSubscription;

void _progress() {
    _progressSubscription =
        new Stream.periodic(const Duration(seconds: 1)).listen((_) {
            output('.', Color.white);
        });
}

void _endProgress() {
    _progressSubscription.cancel();
    stdout.write('\n');
}


main(List<String> args) async {
    var name = toTableName(args[0]);
    output('Cloning template repository', Color.green);
    _progress();
    ProcessResult result;
    try {
        result = await Process.run('git', [
            'clone',
            'https://github.com/lejard-h/angular2_project_template.git',
            '-bmaster',
            '--single-branch',
            name,
        ]);
    } catch (e) {
        output('\n••• Couldn\'t run git clone', Color.red);
    }

    _endProgress();

    if (result.exitCode != 0) {
        output('${result.stderr}\n', Color.red);
        exit(1);
    }

    Directory.current = name;

    try {
        await new Directory('.git').delete(recursive: true);
    } catch (e) {
        output('$e\n', Color.red);
        exit(1);
    }

    Process.runSync("replace", [ "__projectName__", "$name", "--", "pubspec.yaml"]);
    Process.runSync("replace", [ "__projectName__", "$name", "--", "angular.config.yaml"]);
    Process.runSync("replace", [ "__projectName__", "$name", "--", "web/main.dart"]);

    output('Running Pub Get', Color.green);

    _progress();

    try {

        await Process.run('pub', ['get']);
    } catch (e) {
        output('\n••• Couldn\'t run pub get', Color.red);
    }

    _endProgress();

    output('Hint: cd $name &&  grind --help\n', Color.gray);

    return 0;
}