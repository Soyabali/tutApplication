import 'package:dartz/dartz.dart';
import 'package:tut_application/app/functions.dart';
import 'package:tut_application/data/network/failure.dart';
import 'package:tut_application/data/request/request.dart';
import 'package:tut_application/domain/model/model.dart';
import 'package:tut_application/domain/repository/repository.dart';
import 'package:tut_application/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async
  {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(
        input.email, input.password, deviceInfo.identifiers,deviceInfo.name));
  }
}
class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
