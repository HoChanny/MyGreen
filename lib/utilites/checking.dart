//아이디, 비밀번호 체크하는 함수 모음입니다.

import 'dart:convert';


//더미 데이터
String jsonString = '''
{
    "product" : [
        {
            "pid" : 0,
            "id" : "owanys",
            "password" : "qwer123456@"
        },

        {
            "pid" : 1,
            "id" : "micheal",
            "password" : "qwer123456@"
        }
]
}
''';
    
    List<Map<String, dynamic>> products =
      List<Map<String, dynamic>>.from(json.decode(jsonString)['product']);


bool checkingId(String id) {
  for (var product in products) {

    if (id == product['id']) {
      return true; // exit function if id is found
    }
  }

  return false;
}

bool checkingPassword(String password) {
  for (var product in products) {

    if (password == product['password']) {
      return true; // exit function if password is found
    }
  }
  
  return false;
}
