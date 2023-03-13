          // String checkingId(input){
    //   //  아이디 입력 확인
    //   if(input.isEmpty){
    //     return '아이디를 입력하세요.';
    //   } 
    //   else {
    //     //  아이디 정규표현식 확인
    //     if(validId(input)) {
    //       return '';
    //     } else{
    //     }

    //   }
    // }

    //패스워드  숫자 4개 이상 문자 1개이상 특수문자 1개이상 (ex : 2154a@)
      
    //     String checkingPass(input){
    //   //  패스워드 입력 확인
    //   if(input.isEmpty){
    //     return '패스워드를 입력하세요.';
    //   } 
    //   else {
    //     //  패스워드 정규표현식 확인
    //     if(validPassword(input)) {
    //       return '';
    //     } else{
    //       return '패스워드형식은 숫자 4개 이상 문자 1개 이상 특수문자 1개 이상입니다.';
    //     }

    //   }
    // }
    
    // String checkingBirthDay(input){
    //   //  생년월일 입력 확인
    //   if(input.isEmpty){
    //     return '생일 입력하세요.';
    //   } 
    //   else {
    //     //  생년월일 정규표현식 확인
    //     if(validBirthDay(input)) {
    //       return '';
    //     } else{
    //       return '생년월일형식은 숫자 6개로 입력하셔야 합니다. (예시 : 990212)';
    //     }

    //   }
    // }

     //   margin: EdgeInsets.all(20.0), // Set margin for all sides
                    //   child: TextFormField(
                    //     maxLength: 6,
                    //     decoration: InputDecoration(
                    //       focusColor: Colors.white,
                    //       //add prefix icon
                    //       prefixIcon: const Icon(
                    //         Icons.calendar_month,
                    //         color: Colors.grey,
                    //       ),

                    //       //default border
                    //       enabledBorder: UnderlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               width: 2, color: Colors.black), //<-- SEE HERE
                    //           borderRadius: BorderRadius.circular(0.0)),

                    //       //focus border
                    //       focusedBorder: UnderlineInputBorder(
                    //           //<-- SEE HERE
                    //           borderSide: const BorderSide(
                    //               width: 3, color: Colors.greenAccent),
                    //           borderRadius: BorderRadius.circular(0.0)),
                    //     ),
                    //     style: const TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return '1자 이상 입력해주세요.';
                    //       } else {
                    //         if (validBirthDay(value)) {
                    //         } else {
                    //           return '생년월일형식은 숫자 6개 입니다.';
                    //         }
                    //       }
                    //       return null;
                    //     },
                    //     onSaved: (value) {
                    //       setState(() {
                    //         _birthDay = value as String;
                    //       });
                    //     },
                    //   ),
                  