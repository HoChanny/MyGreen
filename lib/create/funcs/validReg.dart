//회원가입 페이지 정규표현식 유효성 검사

//아이디 6~10자리 정규표현식 (ex:ownaysss)
final RegExp idExp = RegExp(r'^[a-zA-Z0-9]{6,10}$');

bool validId(input) {
  if (idExp.hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}

//4 numbers,1 letter, 1 special character.
final RegExp passwordExp =
    RegExp(r'^(?=.*\d{4,})(?=.*[a-zA-Z])(?=.*[@$!%*?&])[a-zA-Z\d@$!%*?&]+$');

bool validPassword(input) {
  if (passwordExp.hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}

final RegExp emailExp =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

bool validEmail(input) {
  if (emailExp.hasMatch(input)) {
    return true;
  } else {
    return false;
  }
}
