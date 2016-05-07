import 'component.dart' as component;
import 'directive.dart' as directive;
import 'service.dart' as service;
import 'pipe.dart' as pipe;
import 'app.dart' as app;
import 'component_inline.dart' as component_inline;
import 'dart:io';

/// Creates a
main(List<String> args) {
  _showHelp(args, 0);
  switch(args[0]) {
    case 'component':
      _showHelp(args, 1);
      component.main(args.getRange(1, args.length).toList());
      break;
    case 'component_inline':
      _showHelp(args, 1);
      component_inline.main(args.getRange(1, args.length).toList());
      break;
    case 'directive':
      _showHelp(args, 1);
      directive.main(args.getRange(1, args.length).toList());
      break;
    case 'service':
      _showHelp(args, 1);
      service.main(args.getRange(1, args.length).toList());
      break;
   case 'pipe':
      _showHelp(args, 1);
      pipe.main(args.getRange(1, args.length).toList());
      break;
 /*   case 'route':
      _showHelp(args, 1);
      service.main(args.getRange(1, args.length).toList());
      break;*/
    case 'new':
     _showHelp(args, 1);
      app.main(args.getRange(1, args.length).toList());
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
  -h, --help                        :   shows this content.
  component <component_name>        :   creates a new folder with the name of component.
  component_inline <component_name> :   creates a new folder with the name of component but without html file.
  directive <directive_name>        :   creates a new directive.
  service <service_name>            :   creates a new service.
  pipe <pipe_name>                  :   creates a new pipe.
''');
    exit(0);
  }
}

String get defaultConfig => '''
project:
  name: "__projectName__"
  components: "lib/components"
  directives: "lib/directives"
  services: "lib/services"
  models: "lib/models"
  routes: "lib/routes"
  pipes: "lib/pipes"

server:
  hostname: "0.0.0.0"
  port: 1337
''';