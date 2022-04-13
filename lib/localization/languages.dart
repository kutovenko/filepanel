import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ru_RU': {
          //general
          'app_name': 'FilePanel',
          //
          'empty_folder': 'Пустая папка',
          //Permissions Screen
          'permissions_rationale': 'Нам нужны разрешения на доступ к файлам',
          'request_permissions': 'Дать разрешения',
          'media_permission': 'Доступ к медиагалерее',
        },
        'en_US': {
          //general
          'app_name': 'FilePanel',
          //
          'empty_folder': 'Empty Folder',
          //Permissions Screen
          'permissions_rationale': 'We need permissions',
          'request_permissions': 'Grant Permissions',
          'media_permission': 'Access to Media Gallery',
          'storage_permission': 'Access to Local Storage',
        },
      };
}
