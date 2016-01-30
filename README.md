# ng2gen

This is an Angular2 Component File Generator

## Installation

To install this package globally you only need to do:

```
pub global activate ng2gen
```

this will download and install `ng2gen_component` executable into `~/.pub-cache/bin`

## Create Component

To create a component you only need to do this:

```
cd path/to/generate/component
pub global run ng2gen:component my_component
```

or you can also add `~/.pub-cache/bin` to your class path and do:

```
cd path/to/generate/component
ng2gen component my_component
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

## Create Directive

To create a directive you only need to do this:

```
cd path/to/generate/component
pub global run ng2gen directive my_directive
```

or you can also add `~/.pub-cache/bin` to your class path and do:

```
cd path/to/generate/component
ng2gen directive my_directive
```

this should generate `my_directive.dart` containing:

```dart
// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Directive(
  selector: '[my-directive]')
class MyDirective {

}
```

## Create Service

To create a service you only need to do this:

```
cd path/to/generate/component
pub global run ng2gen service my_service
```

or you can also add `~/.pub-cache/bin` to your class path and do:

```
cd path/to/generate/component
ng2gen directive my_service
```

this should generate `my_service.dart` containing:

```dart
// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Injectable()
class MyService {

}
```