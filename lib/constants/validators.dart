class Validator<T> {
  bool _isvalid = true;
  String msg;
  T? value;

  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

  Validator(this.value) : msg = "";
  Validator._(this.value, this.msg);

  Validator<T> mandatory({String msg = "El campo es obligatorio"}) {
    if (!_isvalid) return this;
    _isvalid = value != null && value.toString().isNotEmpty;
    this.msg = msg;
    return this;
  }

  Validator<T> equals({required String msg, required T target}) {
    if (!_isvalid) return this;
    _isvalid = value.toString().compareTo(target.toString()) == 0;
    this.msg = msg;
    return this;
  }

  Validator<T> length(
      {String msg = r'Debe tener una longitud entre $min y $max ',
      int min = 0,
      int max = -1}) {
    if (!_isvalid) return this;
    _isvalid = value != null &&
        value.toString().length >= min &&
        value.toString().length <= max;
    this.msg = msg.replaceAll(r'$min', "$min").replaceAll(r'$max', "$max");
    return this;
  }

  Validator<T> isEmail({String msg = "No es un email válido"}) {
    if (!_isvalid) return this;
    _isvalid = _emailRegExp.hasMatch(value.toString().toLowerCase());
    this.msg = msg;
    return this;
  }

  String? validate() {
    return _isvalid ? null : this.msg;
  }
}
