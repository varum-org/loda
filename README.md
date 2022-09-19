## Features

Functional programming in Dart and Flutter.

## Getting started

The loda module is a combination of the two Lodash and Ramda modules. It promotes a more functional programming (FP) friendly style by exporting an instance of loda with its methods wrapped to produce immutable auto-curried iteratee-first data-last methods.

## Usage

install

```dart
# pubspec.yaml
dependencies:
  loda:
      git:
        url: https://github.com/VTNPlusD/loda
        ref: master
```

Ex 1:

```dart
import 'package:loda/loda.dart';

const _ = LodaConstants.placeholder;

final profiles = [
    {
      "name": "John",
      "age": 19,
      "address": {
        "country": "DN",
      },
    },
    {
      "name": "Michel",
      "age": 18,
      "address": {
        "country": "QN",
      },
    },
    {
      "name": "Cel",
      "age": 17,
      "address": {
        "country": 'ĐL',
      },
    },
  ];
  final bool Function(dynamic) isEligible = and([
    has('name'),
    has('age'),
    flow([
      select('age'),
      gte(_, 18),
    ]),
  ]);
  final getCountriesOfEligibleProfiles = flow([
    filter(isEligible),
    map(select('address.country')),
    distinct,
  ]);
  final countries = getCountriesOfEligibleProfiles(profiles);
  print(countries); // [DN, QN]
```

Ex 2:

```dart
import 'package:loda/loda.dart';
import 'package:collection/collection.dart';

   final profiles = [
      {
        "id": "1",
        "address": {
          "city": "DN",
        },
        "name": "Duy Nguyen",
      },
      {
        "id": "2",
        "name": "Minh D",
        "address": {
          "city": "DL",
        }
      },
      {
        "id": "3",
        "name": 'Monad',
        "address": {
          "city": null,
        }
      }
    ];
    Maybe<Map> findMaybe(List<Map>? entries, id) {
      final result = entries?.firstWhereOrNull(
        (obj) => obj["id"] == id,
      );
      return (result?.isNotEmpty ?? false)
          ? Maybe.some(result)
          : Maybe.nothing();
    }

    Function get = curry(
      (key, obj) =>
          obj.containsKey(key) ? Maybe.some(obj[key]) : Maybe.nothing(),
    );

    toLowerCase(String str) => str.toLowerCase();

    findProfileWithId(id) => findMaybe(profiles, id)
        .flatMap(get("address"))
        .flatMap(get("city"))
        .map(toLowerCase)
        .unwrap();

  print(findProfileWithId("1")); // dn

  print(findProfileWithId("3")); // null
```

## Additional information

My article introduces to Functional Programming
[LINK](https://duynn.notion.site/Introduce-to-Functional-Programing-FP-909e3eab2b174632a696692273bceaa8)
