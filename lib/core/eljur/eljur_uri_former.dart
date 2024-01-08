abstract class EljurUriFormer {
  Uri createUri(String method, [Map<String, String>? query]);
}

class EljurUriFormerImpl implements EljurUriFormer {
  @override
  Uri createUri(String method, [Map<String, String>? query]) =>
      Uri.https('school.nso.ru', '/apiv3$method', query);
}
