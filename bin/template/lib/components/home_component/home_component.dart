// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

@Component(
  selector: 'home-component',
  template: '''
        <p>
          home-route works!
        </p>
        ''',
  styleUrls: const ['home_component.css'])
class HomeComponent implements OnInit {

  HomeComponent();

  ngOnInit() {}

}
