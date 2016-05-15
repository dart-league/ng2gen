// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

@Component(
  selector: 'home-route',
  template: '''
        <p>
          home-route works!
        </p>
        ''',
  styleUrls: const ['home_route.css'])
class HomeRoute implements OnInit {

  HomeRoute();

  ngOnInit() {}

}
