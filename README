# ng2gen

This is an Angular2 Component Files Generator

## Installation

To install this package globally you only need to do:

```
pub global activate ng2gen
```

this will download and install `ng2gen_component` executable into `~/.pub-cache/bin`

## Execute

To execute the generator you only need to do this:

```
cd path/to/generate/component
pub global run ng2gen:component my_component
```

or you can also add `~/.pub-cache/bin` to your class path and do:

```
cd path/to/generate/component
ng2gen_component my_component
```

this should generate next files structure:

```
path/to/generate/component
  └─ my_component
       ├─ my_component.dart
       └─ my_component.html
```

where `my_component.dart` contains:

```dart
// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Component(
  selector: 'my-component',
  templateUrl: 'my_component.html')
class MyComponent {

}
```

and `my_component.html` will be empty.