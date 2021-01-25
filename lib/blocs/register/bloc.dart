import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/api/user_api.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';

import 'event.dart';
import 'state.dart';

/// create by 张风捷特烈 on 2021/1/17
/// contact me by email 1981462002@qq.com
/// 说明:

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterNone());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is DoRegister) {
      yield RegisterLoading();
      ResultBean<bool> result =
          await UserApi.register(email: event.email, code: event.code);

      // 注册成功
      if (result.data) {
        yield RegisterSuccess(event.email);
      }else{
        yield RegisterError(result.msg);
      }
    }
  }
}
