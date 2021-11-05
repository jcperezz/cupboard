class Validator<T> {
  bool _isvalid = true;
  String message;
  T? value;

  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

  Validator(this.value) : message = "";
  Validator._(this.value, this.message);

  Validator<T> mandatory({String message = "El campo es obligatorio"}) {
    if (!_isvalid) return this;
    _isvalid = value != null && value.toString().isNotEmpty;
    this.message = message;
    return this;
  }

  Validator<T> length(
      {String message = "Debe tener una longitud", int min = 0, int max = -1}) {
    if (!_isvalid) return this;
    _isvalid = value != null &&
        value.toString().length >= min &&
        value.toString().length <= max;
    this.message = message;
    return this;
  }

  Validator<T> isEmail({String message = "No es un email válido"}) {
    if (!_isvalid) return this;
    _isvalid = _emailRegExp.hasMatch(value.toString().toLowerCase());
    this.message = message;
    return this;
  }

  String? validate() {
    return _isvalid ? null : this.message;
  }
}
