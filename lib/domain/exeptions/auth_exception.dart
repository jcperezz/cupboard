import 'package:cupboard/domain/exeptions/abstract_exception.dart';

class AuthException extends AbstractAppException {
  const AuthException(String label, [String? detail]) : super(label, detail);
}
