import 'package:cupboard/domain/exeptions/abstract_exception.dart';

class PersistenceException extends AbstractAppException {
  const PersistenceException(String label, [String? detail])
      : super(label, detail);
}
