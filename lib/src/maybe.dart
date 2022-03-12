import 'filter.dart' as _filter;
import 'just.dart';
import 'map.dart' as _map;
import 'nothing.dart';
import 'utils/is_nil.dart';
import 'flat_map.dart' as _flatMap;

class Maybe<T> {
  final T _value;

  Maybe(this._value);

  bool get isNothing => _value is Nothing || isNil(_value);

  Maybe map(f) => isNothing ? this : Maybe(_map.map(f)(_value));

  Maybe filter(f) => isNothing ? this : Maybe(_filter.filter(f)(_value));

  unwrap() => _value;

  E flatMap<E>(f) => isNothing ? this : _flatMap.flatMap(f)(_value);

  Just getOrElse<E>(E defaultV) =>
      isNothing || isNil(_value) ? Just(defaultV) : Just(_value);

  orNull() => isNil(_value) ? null : _value;

  Maybe orElse<E>(E defaultV) => isNothing ? Maybe(defaultV) : this;

  @override
  bool operator ==(Object other) {
    if (other is Maybe) return _value == other._value;

    if (other is Just) return other == Just(_value);

    return other == _value;
  }

  @override
  int get hashCode => _value.hashCode;
}
