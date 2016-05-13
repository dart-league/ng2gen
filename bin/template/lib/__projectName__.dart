library __projectName__;

import 'package:angular2/core.dart';

export "models.dart";
export "convert/convert.dart";
export "services/services.dart";
export "pipes/pipes.dart";
export "directives/directives.dart";
export "routes/routes.dart";
export "components/components.dart";

@Component(selector: 'my-app', template: '<h1>My First Angular 2 App</h1>')
class AppComponent {}
