import 'package:cupboard/domain/exceptions/abstract_exception.dart';

class PersistenceException extends AbstractAppException {
  const PersistenceException(String label, [String? detail])
      : super(label, detail);
}
