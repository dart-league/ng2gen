library __projectName__;

import 'package:angular2/core.dart';
import "package:angular2/router.dart";

export "models.dart";
export "convert/convert.dart";
export "services/services.dart";
export "pipes/pipes.dart";
export "directives/directives.dart";
export "routes/routes.dart";
export "components/components.dart";

import "routes/routes.dart";

@Component(
    selector: 'my-app',
    templateUrl: "__projectName__.html",
    directives: const [ROUTER_DIRECTIVES])
@RouteConfig(const [
  const Route(
      useAsDefault: false, path: '/home', name: 'Home', component: HomeRoute)
])
class AppComponent {}
