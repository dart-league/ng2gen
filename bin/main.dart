import 'dart:io';

import 'component.dart' as component;
import 'directive.dart' as directive;
import 'service.dart' as service;
import 'pipe.dart' as pipe;
import 'app.dart' as app;
import 'component_inline.dart' as component_inline;
import 'route.dart' as route;
import 'init.dart' as init;

/// Creates a component, directive or service in dependence of the passed arguments
main(List<String> args) {
  _showHelp(args, 0);
  switch(args[0]) {
    case 'init':
      _showHelp(args, 0);
      init.main(args.getRange(1, args.length).toList());
      break;
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
    case 'route':
      _showHelp(args, 2);
      route.main(args.getRange(1, args.length).toList());
      break;
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
  new <app_name>                    :   create a new Angular2 application.
  component <component_name>        :   create a new folder with the name of component.
  component_inline <component_name> :   create a new folder with the name of component but without html file.
  directive <directive_name>        :   create a new directive.
  service <service_name>            :   create a new service.
  pipe <pipe_name>                  :   create a new pipe.
  route <route_name> <route_path>   :   create a new route.
  init                              :   init an existing project with ng2gen
''');
    exit(0);
  }
}
