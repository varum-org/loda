// Maybe

/// The Maybe type encapsulates an optional value.
/// Using Maybe is a good way to deal with errors or
/// exceptional cases without resorting to
/// drastic measures such as error.
abstract class Maybe<T> {
  Maybe<U> map<U>(U Function(T) f);

  Maybe<U> apply<U>(Maybe<U Function(T)> f);

  Maybe<U> flatMap<U>(Maybe<U> Function(T) f);

  T unwrap();
}

/// Represents a value of type Maybe that contains a value
/// (represented as Just a).
class Just<T> extends Maybe<T> {
  Just(this.value);
  final T value;

  @override
  Maybe<U> map<U>(U Function(T) f) => Just(f(value));

  @override
  Maybe<U> apply<U>(covariant Maybe<U Function(T)> f) =>
      f.map((ff) => ff(value));

  @override
  Maybe<U> flatMap<U>(covariant Maybe<U> Function(T) f) => f(value);

  @override
  String toString() => 'Just $value';

  @override
  T unwrap() => value;
}

/// Represents an empty Maybe that holds nothing
/// (in which case it has the value of Nothing)
class Nothing<T> extends Maybe<T> {
  @override
  Maybe<U> map<U>(U Function(T) f) => Nothing();

  @override
  Maybe<U> apply<U>(covariant Maybe<U Function(T)> f) => Nothing();

  @override
  Maybe<U> flatMap<U>(covariant Maybe<U> Function(T) f) => Nothing();

  @override
  String toString() => 'Nothing';

  @override
  T unwrap() => null as T;
}
