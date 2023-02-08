import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';

abstract class EljurUriFormer {
  Uri formUrl(String method, Map<String, String> params,
      [TokenInfo? tokenInfo]);
}

class EljurUriFormerImpl implements EljurUriFormer {
  @override
  Uri formUrl(String method, Map<String, String> params,
          [TokenInfo? tokenInfo]) =>
      Uri.https(
          'school.nso.ru',
          '/apiv3/$method',
          params
            ..addAll({
              if (!(tokenInfo?.expired ?? true)) 'auth_token': tokenInfo!.token,
              'vendor': 'school',
              'devKey': '0c7968cd2b6e14a4eed3c94e593ae9f0'
            }));
}
