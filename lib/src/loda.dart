import 'dart:collection';
import 'package:dartz/dartz.dart';

class Placeholder {
  const Placeholder();
}

extension ExtPlaceholder on Placeholder {
  bool Function(num) operator >=(num b) => (num a) => a >= b;

  bool Function(num) operator >(num b) => (num a) => a > b;

  bool Function(num) operator <=(num b) => (num a) => a <= b;

  bool Function(num) operator <(num b) => (num a) => a < b;
}

typedef Predicate<T> = bool Function(T value);

class Pipeline<T, R> {
  final R Function(T) run;

  Pipeline(this.run);

  Pipeline<T, S> then<S>(S Function(R) next) {
    return Pipeline<T, S>((T input) => next(run(input)));
  }

  Pipeline<T, Either<L, S>> thenEither<L, S>(Either<L, S> Function(R) next) {
    return Pipeline<T, Either<L, S>>((T input) => next(run(input)));
  }

  R call(T input) => run(input);
}

extension EitherPipelineExtension<L, T, R> on Pipeline<T, Either<L, R>> {
  Pipeline<T, Either<L, S>> mapEitherRight<S>(S Function(R) f) {
    return Pipeline<T, Either<L, S>>((T input) {
      return run(input).fold(
        Left.new,
        (r) => Right(f(r)),
      );
    });
  }

  Pipeline<T, Either<L2, R>> mapEitherLeft<L2>(L2 Function(L) f) {
    return Pipeline<T, Either<L2, R>>((T input) {
      return run(input).fold(
        (l) => Left(f(l)),
        Right.new,
      );
    });
  }

  Pipeline<T, Either<L2, S>> mapEitherBoth<L2, S>(
    L2 Function(L) f1,
    S Function(R) f2,
  ) {
    return Pipeline<T, Either<L2, S>>((T input) {
      return run(input).fold(
        (l) => Left(f1(l)),
        (r) => Right(f2(r)),
      );
    });
  }
}

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
}
