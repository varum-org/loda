## Features

Functional programming in Dart and Flutter.

## Getting started

The loda module is a combination of the two Lodash and Ramda modules. It promotes a more functional programming (FP) friendly style by exporting an instance of loda with its methods wrapped to produce immutable auto-curried iteratee-first data-last methods.

## Usage

Examples

```dart
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
  print(countries); // [QN, ĐL]
```

## Additional information

My article introduces to Functional Programming
[LINK](https://duynn.notion.site/Introduce-to-Functional-Programing-FP-909e3eab2b174632a696692273bceaa8)
