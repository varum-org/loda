import 'package:flutter_test/flutter_test.dart';
import 'package:loda/loda.dart';
import 'package:collection/collection.dart';

const _ = LodaConstants.placeholder;

void main() {
  test('Test 1', () {
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
    expect(countries, ["DN", "QN"]);
  });

  test('Test 2', () {
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

    expect(findProfileWithId("1"), 'dn');
    expect(findProfileWithId("3"), null);
  });
}
