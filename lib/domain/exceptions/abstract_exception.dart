abstract class AbstractAppException implements Exception {
  const AbstractAppException(this.label, [this.detail]);

  final String label;
  final String? detail;

  @override
  String toString() {
    String result = label;
    if (detail is String) return "$result: $detail";
    return result;
  }
}
