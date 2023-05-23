import 'package:hooks_riverpod/hooks_riverpod.dart';

class ValidationNotifier<T> extends StateNotifier<ValidationValue<T>> {
  final String? Function(T value) validator;

  ValidationNotifier({
    required this.validator,
    required T intialValue,
  }) : super(ValidationValue(intialValue));

  bool validate() {
    final error = validator(state.value);
    state = ValidationValue(state.value, error: error);
    return error == null;
  }

  void update(
    T Function(T value) update,
  ) {
    final newVal = update(state.value);
    state = state.copyWith(value: newVal);
  }

  T get value => state.value;

  set value(T value) => state = state.copyWith(value: value);
}

class ValidationValue<T> {
  final T value;
  final String? error;

  const ValidationValue(this.value, {this.error});

  ValidationValue<T> copyWith({
    T? value,
    String? error,
  }) {
    return ValidationValue<T>(
      value ?? this.value,
      error: error ?? this.error,
    );
  }
}
