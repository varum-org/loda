import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:loda/src/core.dart';

class FP {
  static const p = Placeholder();

  static Pipeline<T, T> pipe<T>() => Pipeline<T, T>((t) => t);

  static Either<L, R> chainEither<L, T, R>(
    Either<L, T> either,
    Pipeline<T, R> pipeline,
  ) {
    return either.fold(
      Left.new,
      (t) => Right(pipeline(t)),
    );
  }

  static Predicate<T> and<T>(List<Predicate<T>> predicates) {
    return (T arg) {
      if (arg == null) {
        assert(false, 'Argument cannot be null');
      }
      for (final predicate in predicates) {
        if (!predicate(arg)) return false;
      }
      return true;
    };
  }

  static Predicate<T> or<T>(List<Predicate<T>> predicates) {
    return (T arg) {
      if (arg == null) {
        assert(false, 'Argument cannot be null');
      }
      for (final predicate in predicates) {
        if (predicate(arg)) return true;
      }
      return false;
    };
  }

  static List<T> Function(Iterable<T>) filter<T>(bool Function(T) predicate) {
    return (Iterable<T> items) {
      return items.where(predicate).toList();
    };
  }

  static List<T> Function(Iterable<T>) filterIndex<T>(
      bool Function(int, T) predicate) {
    return (Iterable<T> items) {
      final result = <T>[];
      for (final (index, item) in items.indexed) {
        if (predicate(index, item)) {
          result.add(item);
        }
      }
      return result;
    };
  }

  static Map<K, V> Function(Map<K, V>) filterMap<K, V>(
    bool Function(K, V) predicate,
  ) {
    return (Map<K, V> items) {
      return items.entries
          .where((entry) => predicate(entry.key, entry.value))
          .fold<Map<K, V>>({}, (map, entry) {
        map[entry.key] = entry.value;
        return map;
      });
    };
  }

  static List<R> Function(Iterable<T>) map<T, R>(
    R Function(T) mapper,
  ) {
    return (Iterable<T> items) {
      return items.map(mapper).toList();
    };
  }

  static List<R> Function(Iterable<T>) mapIndex<T, R>(
    R Function(int, T) mapper,
  ) {
    return (Iterable<T> items) {
      return items.indexed.map((e) => mapper(e.$1, e.$2)).toList();
    };
  }

  static Map<K2, V2> Function(Map<K, V>) mapMap<K, V, K2, V2>(
      MapEntry<K2, V2> Function(K, V) mapper) {
    return (Map<K, V> items) {
      return items.entries
          .map((entry) => mapper(entry.key, entry.value))
          .fold<Map<K2, V2>>({}, (map, entry) {
        map[entry.key] = entry.value;
        return map;
      });
    };
  }

  static List<R> Function(Iterable<T>) flatMap<T, R>(
      Iterable<R> Function(T) mapper) {
    return (Iterable<T> items) {
      return items.expand(mapper).toList();
    };
  }

  static List<T> Function(Iterable<T>) distinct<T>() {
    return (Iterable<T> items) {
      return LinkedHashSet<T>.from(items).toList();
    };
  }

  static Map<K, V> Function(Map<K, V>) distinctMap<K, V>() {
    return (Map<K, V> items) {
      return LinkedHashMap<K, V>.from(items);
    };
  }

  static T Function(Iterable<T>) reduce<T>(
    T Function(T previous, T current) reducer,
  ) {
    return (items) => items.reduce(reducer);
  }

  static Map<K, List<T>> Function(Iterable<T>) groupBy<T, K>(
    K Function(T) keySelector,
  ) {
    return (items) {
      final map = <K, List<T>>{};
      for (final item in items) {
        final key = keySelector(item);
        map.putIfAbsent(key, () => []).add(item);
      }
      return map;
    };
  }

  static (List<T>, List<T>) Function(Iterable<T>) partition<T>(
    bool Function(T) predicate,
  ) {
    return (items) {
      final pass = <T>[];
      final fail = <T>[];
      for (final item in items) {
        (predicate(item) ? pass : fail).add(item);
      }
      return (pass, fail);
    };
  }

  static R Function(T) ifElse<T, R>(
    bool Function(T) predicate,
    R Function(T) ifTrue,
    R Function(T) ifFalse,
  ) {
    return (T input) => predicate(input) ? ifTrue(input) : ifFalse(input);
  }

  static R? Function(T) when<T, R>(
    bool Function(T) predicate,
    R Function(T) action,
  ) {
    return (T input) => predicate(input) ? action(input) : null;
  }

  static R Function(T) cond<T, R>(
    List<(bool Function(T), R Function(T))> cases,
    R Function(T) orElse,
  ) {
    return (T input) {
      for (final caseEntry in cases) {
        if (caseEntry.$1(input)) {
          return caseEntry.$2(input);
        }
      }
      return orElse(input);
    };
  }
}
