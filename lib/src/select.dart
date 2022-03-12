import 'select_array.dart';

Function select = (String pathArrayString) =>
    (obj) => selectFromArr(pathArrayString.split('.'), obj);
