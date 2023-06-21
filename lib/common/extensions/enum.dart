extension EnumUtils on Enum {
  String get name => toString().split('.').last;
}
