library __projectName__;

import 'package:angular2/core.dart';
import "package:angular2/router.dart";
import "routes.dart";

@Component(
    selector: 'my-app',
    templateUrl: "app.html",
    directives: const [ROUTER_DIRECTIVES])
@RouteConfig(const [
])
class AppComponent {}
