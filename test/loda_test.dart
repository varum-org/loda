import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loda/loda.dart';

void main() {
  group('Placeholder Operator Tests', () {
    test('>= operator', () {
      final greaterThanOrEqual = FP.p >= 5;
      expect(greaterThanOrEqual(6), isTrue);
      expect(greaterThanOrEqual(5), isTrue);
      expect(greaterThanOrEqual(4), isFalse);
    });

    test('> operator', () {
      final greaterThan = FP.p > 5;
      expect(greaterThan(6), isTrue);
      expect(greaterThan(5), isFalse);
      expect(greaterThan(4), isFalse);
    });
  });

  group('Pipeline Tests', () {
    test('Pipeline chaining', () {
      final pipeline = Pipeline<int, int>((x) => x * 2).then((x) => x + 3);
      expect(pipeline(4), equals(11));
    });

    test('Pipeline with Either', () {
      final pipeline = Pipeline<int, Either<String, int>>(
          (x) => x > 0 ? Right(x * 2) : const Left("Negative"));
      expect(pipeline(3), equals(const Right(6)));
      expect(pipeline(-1), equals(const Left("Negative")));
    });
  });

  group('FP Utility Tests', () {
    test('and Predicate', () {
      isEven(int x) => x % 2 == 0;
      isPositive(int x) => x > 0;
      final andPredicate = FP.and([isEven, isPositive]);
      expect(andPredicate(4), isTrue);
      expect(andPredicate(-4), isFalse);
      expect(andPredicate(3), isFalse);
    });

    test('or Predicate', () {
      isEven(int x) => x % 2 == 0;
      isNegative(int x) => x < 0;
      final orPredicate = FP.or([isEven, isNegative]);
      expect(orPredicate(4), isTrue);
      expect(orPredicate(-3), isTrue);
      expect(orPredicate(3), isFalse);
    });

    test('filter', () {
      final numbers = [1, 2, 3, 4, 5];
      final filterEven = FP.filter<int>((x) => x % 2 == 0);
      expect(filterEven(numbers), equals([2, 4]));
    });

    test('distinct', () {
      final numbers = [1, 2, 2, 3, 4, 4, 5];
      final distinctNumbers = FP.distinct<int>();
      expect(distinctNumbers(numbers), equals([1, 2, 3, 4, 5]));
    });
  });
}
