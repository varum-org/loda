import 'has_array.dart';

Function has = (String pathArrayString) =>
    (obj) => hasFromArray(pathArrayString.split('.'), obj);
