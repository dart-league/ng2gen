/**
 * Created by lejard_h on 13/05/16.
 */

import "dart:io";
import "dart:convert";

//import 'package:crypto/crypto.dart';
import 'package:grinder/grinder.dart';
import 'package:path/path.dart' as path;

main(List<String> args) => grind(args);


@Task('Concatenate the template files into runtime data files')
void build() {
  _concatenateFiles(
      getDir('bin/template'),
      getFile(
          'bin/app_template_data.dart'));
}

void _concatenateFiles(Directory src, File target) {
  log('Creating ${target.path}');

  String str = _traverse(src, '').map((s) => '  ${_toStr(s)}').join(',\n');

  target.writeAsStringSync("""
// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
const List<String> data = const [
${str}
];
""");
}

String _toStr(String s) {
  if (s.contains('\n')) {
    return '"""${s}"""';
  } else {
    return '"${s}"';
  }
}

Iterable<String> _traverse(Directory dir, String root) sync* {
  var files = _listSync(dir, recursive: false, followLinks: false);
  for (FileSystemEntity entity in files) {
    if (entity is Link) continue;

    String name = path.basename(entity.path);
    if (name == 'pubspec.lock') continue;
    if (name.startsWith('.') && name != '.gitignore') continue;

    if (entity is Directory) {
      yield* _traverse(entity, '${root}${name}/');
    } else {
      yield '${root}${name}';
      yield _isBinaryFile(name) ? 'binary' : 'text';
      yield BASE64.encode((entity as File).readAsBytesSync());
    }
  }
}

final RegExp _binaryFileTypes = new RegExp(
    r'\.(jpe?g|png|gif|ico|svg|ttf|eot|woff|woff2)$',
    caseSensitive: false);

/**
 * Returns true if the given [filename] matches common image file name patterns.
 */
bool _isBinaryFile(String filename) => _binaryFileTypes.hasMatch(filename);

/**
 * Return the list of children for the given directory. This list is normalized
 * (by sorting on the file path) in order to prevent large merge diffs in the
 * generated template data files.
 */
List<FileSystemEntity> _listSync(Directory dir,
    {bool recursive: false, bool followLinks: true}) {
  List<FileSystemEntity> results =
  dir.listSync(recursive: recursive, followLinks: followLinks);
  results.sort((entity1, entity2) => entity1.path.compareTo(entity2.path));
  return results;
}