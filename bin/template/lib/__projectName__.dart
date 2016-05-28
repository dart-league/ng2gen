library __projectName__;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

export 'services/services.dart';
export 'pipes/pipes.dart';
export 'directives/directives.dart';
export 'components/components.dart';

import 'components/components.dart';

@Component(
    selector: 'my-app',
    templateUrl: '__projectName__.html',
    directives: const [ROUTER_DIRECTIVES])
@RouteConfig(const [
  const Route(useAsDefault: false, path: '/home', name: 'Home', component: HomeComponent)
])
class AppComponent {}
