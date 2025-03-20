# Loda

[![pub package](https://img.shields.io/pub/v/loda.svg)](https://pub.dev/packages/loda)
[![package publisher](https://img.shields.io/pub/publisher/loda.svg)](https://pub.dev/packages/loda/publisher)

## Features

Functional programming in Dart and Flutter.

## Getting started

The loda module is a combination of the two Lodash and Ramda modules. It promotes a more functional programming (FP) friendly style by exporting an instance of loda with its methods wrapped to produce immutable auto-curried iteratee-first data-last methods.

## Installation

install

```dart
# pubspec.yaml
dependencies:
  loda: ^1.0.3
```

## Placeholder

`Placeholder` is a helper class that allows defining mathematical comparisons as functions.

### Operators

- `>= (num b)`: Returns a function that checks if a number is greater than or equal to `b`.
- `> (num b)`: Returns a function that checks if a number is greater than `b`.
- `<= (num b)`: Returns a function that checks if a number is less than or equal to `b`.
- `< (num b)`: Returns a function that checks if a number is less than `b`.

## Pipeline

The `Pipeline<T, R>` class is used for function composition and chaining.

### Methods

- `then<S>(S Function(R) next)`: Chains another function to transform the output.
- `thenEither<L, S>(Either<L, S> Function(R) next)`: Chains a function that returns an `Either` type.
- `call(T input)`: Executes the pipeline on an input.

### Extensions for Either

- `mapEitherRight<S>(S Function(R) f)`: Transforms the `Right` value of `Either`.
- `mapEitherLeft<L2>(L2 Function(L) f)`: Transforms the `Left` value of `Either`.
- `mapEitherBoth<L2, S>(L2 Function(L) f1, S Function(R) f2)`: Transforms both `Left` and `Right` values.

## Functional Programming Utilities (FP)

A collection of functional programming utilities under `FP`.

### Functions

- `pipe<T>()`: Creates an identity pipeline.
- `chainEither<L, T, R>(Either<L, T> either, Pipeline<T, R> pipeline)`: Applies a pipeline to an `Either` value.

#### Predicate Utilities

- `and<T>(List<Predicate<T>> predicates)`: Combines multiple predicates using logical AND.
- `or<T>(List<Predicate<T>> predicates)`: Combines multiple predicates using logical OR.

#### Filtering and Mapping

- `filter<T>(bool Function(T) predicate)`: Filters a list based on a predicate.
- `filterIndex<T>(bool Function(int, T) predicate)`: Filters a list based on the index and value.
- `filterMap<K, V>(bool Function(K, V) predicate)`: Filters a map based on key-value pairs.
- `map<T, R>(R Function(T) mapper)`: Maps over a list.
- `mapIndex<T, R>(R Function(int, T) mapper)`: Maps over a list with index values.
- `mapMap<K, V, K2, V2>(MapEntry<K2, V2> Function(K, V) mapper)`: Maps over a map.
- `flatMap<T, R>(Iterable<R> Function(T) mapper)`: Maps and flattens a list.

#### Distinct Operations

- `distinct<T>()`: Removes duplicates from a list.
- `distinctMap<K, V>()`: Removes duplicate entries from a map.

## Usage

```dart
final isPositive = (int x) => x > 0;
final isEven = (int x) => x % 2 == 0;

final check = FP.and([isPositive, isEven]);
print(check(4)); // true
print(check(-2)); // false

```

## Additional information

My article introduces to Functional Programming
[LINK](https://duynn.notion.site/Introduce-to-Functional-Programing-FP-909e3eab2b174632a696692273bceaa8)
