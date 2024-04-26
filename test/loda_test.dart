import 'package:flutter_test/flutter_test.dart';
import 'package:loda/loda.dart';
import 'package:loda/src/curry/curry3.dart';
import 'package:collection/collection.dart';

const _ = LodaConstants.placeholder;

void main() {
  test('Functor', () {
    num plus(num x) => x + 1;
    expect(Just(2).map(plus), Just(3));
    expect(Nothing<num>().map(plus), Nothing());
    expect([1, 2, 3].map((x) => x + 2), [3, 4, 5]);
    final foo = map<int>((x) => x + 3, (x) => x + 2);
    expect(foo(10), 15);
  });

  test('Aplicatives', () {
    expect(Just(2).apply(Just((x) => x + 3)), Just(5));
    expect(
        [1, 2, 3].mMap<int, int>([
          (x) => x * 2,
          (x) => x + 3,
        ]),
        [2, 4, 6, 4, 5, 6]);
    curriedAddition(num x) => (num y) => x + y;
    final a = Just(3).map(curriedAddition); // Just<(int) => int>
    // Just(5).map(a); // COMPILATION ERROR
    expect(Just(5).apply(a), 15);
    curriedTimes(int x) => (int y) => x * y;
    // num Function(num) curriedTimes(num x) => (num y) => x * y;
    expect(Just(5).apply(Just(3).map(curriedTimes)), Just(15));
  });

  test('Monads', () {
    Maybe<num> half(num a) => a % 2 == 0 ? Just(a / 2) : Nothing();
    expect(Just(3).flatMap(half), Nothing());
    expect(Just(4).flatMap(half), Just(2));
    expect(Nothing<num>().flatMap(half), Nothing());
    expect(Just(20).flatMap(half).flatMap(half).flatMap(half), Nothing());
  });

  test('VD 1', () {
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
      fmap(select('address.country')),
      distinct,
    ]);
    final countries = getCountriesOfEligibleProfiles(profiles);
    expect(countries, ["DN", "QN"]);
  });

  test('VD 2', () {
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
      }
    ];
    final findBy = curry3((String key, String id, List entries) {
      final result = entries.firstWhereOrNull(
        (obj) => obj[key] == id,
      );
      return isNotNil(result) && (result?.isNotEmpty ?? false)
          ? Just(result!)
          : Nothing();
    });

    final findById = findBy("id");

    Maybe Function(dynamic) get(String key) =>
        (obj) => (obj.containsKey(key) ? Just(obj[key]) : Nothing());

    String toLowerCase(str) => str.toLowerCase();

    findProfileWithId(id) => Just(profiles)
        .flatMap(findById(id))
        .flatMap(get("address"))
        .flatMap(get("city"))
        .map<String>(toLowerCase)
        .unwrap();

    expect(findProfileWithId("1"), 'dn');
    // expect(findProfileWithId("3"), null);
  });
}

// Helpers
typedef IntFunction<T> = T Function(T);
IntFunction<T> map<T>(IntFunction<T> f, IntFunction<T> g) => (x) => f(g(x));

extension ApplicativeList on List {
  Iterable<U> mMap<T, U>(List<U Function(T)> list) sync* {
    for (final item in list) {
      for (var i = 0; i < length; i++) {
        yield item(this[i]);
      }
    }
  }

  dynamic firstWhereOrNull(bool Function(dynamic element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
