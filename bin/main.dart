import 'component.dart' as component;
import 'directive.dart' as directive;
import 'service.dart' as service;
import 'dart:io';

/// Creates a
main(List<String> args) {
  _showHelp(args, 0);
  switch(args[0]) {
    case 'component':
      _showHelp(args, 1);
      component.main(args.getRange(1, args.length).toList());
      break;
    case 'directive':
      _showHelp(args, 1);
      directive.main(args.getRange(1, args.length).toList());
      break;
    case 'service':
      _showHelp(args, 1);
      service.main(args.getRange(1, args.length).toList());
      break;
    case '--help':
    case '-h':
    default:
      _showHelp(); break;
  }
}

void _showHelp([List<String> args, int index]) {
  if(args == null || args.isEmpty || args.length <= index) {
    print('''
USAGE:
  -h, --help                :   shows this content
  component <component_name>:   creates a new folder with the name of component containing `<component_name>`.dart and component.html
  directive <directive_name>:   creates a new file `<directive_name>.dart`
  service <service_name>    :   creates a new file `<service_name>.dart`
''');
    exit(0);
  }
}