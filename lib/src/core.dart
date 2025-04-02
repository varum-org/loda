import 'package:dartz/dartz.dart';

class Placeholder {
  const Placeholder();
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
