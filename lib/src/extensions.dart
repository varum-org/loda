import 'package:dartz/dartz.dart';
import 'package:loda/src/core.dart';

extension ComparablePlaceholder<T extends Comparable> on Placeholder {
  bool Function(T) operator >=(T b) => (T a) => a.compareTo(b) >= 0;
  bool Function(T) operator >(T b) => (T a) => a.compareTo(b) > 0;
  bool Function(T) operator <=(T b) => (T a) => a.compareTo(b) <= 0;
  bool Function(T) operator <(T b) => (T a) => a.compareTo(b) < 0;
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
