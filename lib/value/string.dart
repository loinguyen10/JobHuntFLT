import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Hello': 'Hello',
          'App_Name': 'JobsHunt',
          'Email': 'Email',
          'Password': 'Password',
          'Login': 'Login',
        },
        'vi_VN': {
          'Hello': 'Xin Chào',
          'App_Name': 'JobsHunt',
          'Email': 'Email',
          'Password': 'Mật khẩu',
          'Login': 'Đăng nhập',
        },
      };
}
