import 'filter.dart' as _filter;
import 'map.dart' as _map;
import 'flat_map.dart' as _flatMap;
import 'nothing.dart';
import 'utils/is_nil.dart';

class Just<T> {
  final T _value;

  Just(this._value);

  bool get isNothing => _value is Nothing || isNil(_value);

  E flatMap<E>(f) => isNothing ? this : _flatMap.flatMap(f)(_value);

  unwrap() => _value;

  Just map(f) => isNothing ? this : Just(_map.map(f)(_value));

  Just filter(f) => isNothing ? this : Just(_filter.filter(f)(_value));

  getOrNull() => isNothing ? null : _value;

  getOrElse<E>(E a) => isNothing ? a : _value;

  @override
  bool operator ==(Object other) =>
      other is Just ? _value == other.unwrap() : _value == other;

  @override
  int get hashCode => _value.hashCode;
}
