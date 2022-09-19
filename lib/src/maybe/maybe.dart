class Maybe<T> {
  final bool _isNothing;
  final T? _value;

  Maybe.nothing()
      : _isNothing = true,
        _value = null;

  Maybe.some(
    this._value, {
    bool nullable = false,
    bool Function(T? value)? nothingWhen,
  }) : _isNothing = (!nullable && _value == null) ||
            (nothingWhen != null && nothingWhen(_value));

  @override
  int get hashCode => isNothing(this) ? 0 : _value.hashCode;

  @override
  bool operator ==(other) {
    if (other is Maybe<T>) {
      var oNothing = isNothing(other);
      var thisNothing = isNothing(this);
      return (oNothing && thisNothing) ||
          (!oNothing && !thisNothing && other._value == _value);
    }
    if (isNothing(this)) {
      return true;
    }
    return false;
  }

  T? unwrap() {
    return _isNothing ? null : _value;
  }

  Maybe<E> flatMap<E>(f) => _isNothing ? Maybe.nothing() : f(_value);

  Maybe<T> map(f) => _isNothing ? Maybe.nothing() : Maybe.some(f(_value));

  static Maybe<E> flatten<E>(Maybe<Maybe<E>>? maybe) {
    if (maybe == null || maybe._isNothing) {
      return Maybe.nothing();
    }
    return maybe._value!;
  }

  static Iterable<E> filter<E>(Iterable<Maybe<E>>? maybeIterable) {
    return (maybeIterable == null)
        ? Iterable<E>.empty()
        : maybeIterable.where((v) => !v._isNothing).map((v) => v._value!);
  }

  static void forEach<E>(
    Iterable<Maybe<E>>? maybeIterable,
    void Function(E element) f,
  ) {
    if (maybeIterable == null) {
      maybeIterable
          ?.where((v) => !v._isNothing)
          .map((v) => v._value)
          .forEach((element) {
        f(element!);
      });
    }
  }

  static int count<E>(Iterable<Maybe<E>>? maybeList) {
    return (maybeList == null)
        ? 0
        : maybeList.where((v) => !v._isNothing).length;
  }

  static T someFrom<T>(Maybe<T> maybe, T defaultValue) {
    if (isNothing(maybe)) {
      return defaultValue;
    }
    return maybe._value!;
  }

  static Maybe<U> mapSome<T, U>(Maybe<T> maybe, U Function(T v) converter) {
    if (isNothing(maybe)) {
      return Maybe<U>.nothing();
    }
    return Maybe.some(converter(maybe._value!));
  }

  static bool isNothing<T>(Maybe<T> maybe) {
    if (maybe._isNothing) {
      return true;
    }
    return false;
  }

  static bool isSome<T>(Maybe<T> maybe) => !isNothing(maybe);

  static void when<T>(
    Maybe<T> maybe, {
    MaybeNothing? nothing,
    MaybeSome<T?>? some,
    MaybeDefault<T>? defaultValue,
  }) {
    if (isNothing(maybe)) {
      if (defaultValue != null) {
        if (some != null) {
          some(defaultValue());
        }
      } else if (nothing != null) {
        nothing();
      }
    } else if (some != null) {
      some(maybe._value);
    }
  }
}

typedef MaybeNothing = void Function();

typedef MaybeSome<T> = void Function(T value);

typedef MaybeDefault<T> = T Function();
