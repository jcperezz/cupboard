import 'package:cupboard/locale/labels.dart';
import 'package:flutter/cupertino.dart';

class Validator<T> {
  bool _isvalid = true;
  String msg;
  T? value;
  BuildContext context;

  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

  Validator(this.context, this.value) : msg = "";
  Validator._(this.context, this.value, this.msg);

  Validator<T> mandatory({String msg = "validator_field_mandatory"}) {
    if (!_isvalid) return this;
    _isvalid = value != null && value.toString().isNotEmpty;
    this.msg = Labels.of(context).getMessage(msg);
    return this;
  }

  Validator<T> equals({required String msg, required T target}) {
    if (!_isvalid) return this;
    _isvalid = value.toString().compareTo(target.toString()) == 0;
    this.msg = Labels.of(context).getMessage(msg);
    return this;
  }

  Validator<T> length(
      {String msg = "validator_length_min_max", int min = 0, int max = -1}) {
    if (!_isvalid) return this;
    _isvalid = value != null &&
        value.toString().length >= min &&
        value.toString().length <= max;

    this.msg = Labels.of(context).getMessage(msg, [min, max]);
    return this;
  }

  Validator<T> isEmail({String msg = "validator_invalid_email"}) {
    if (!_isvalid) return this;

    _isvalid = _emailRegExp.hasMatch(value.toString().toLowerCase());

    this.msg = Labels.of(context).getMessage(msg);
    return this;
  }

  String? validate() {
    return _isvalid ? null : this.msg;
  }
}
