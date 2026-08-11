import 'dart:convert';

const _fnvOffsetBasis = 0x811c9dc5;
const _fnvPrime = 0x01000193;
const _fnvMask = 0xffffffff;

int stableHash(String input) {
  var hash = _fnvOffsetBasis;
  for (final byte in utf8.encode(input)) {
    hash = ((hash ^ byte) * _fnvPrime) & _fnvMask;
  }
  return hash & 0x7fffffff;
}
