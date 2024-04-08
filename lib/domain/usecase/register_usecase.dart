import 'package:dartz/dartz.dart';
import 'package:tut_application/data/network/failure.dart';
import 'package:tut_application/data/request/request.dart';
import 'package:tut_application/domain/model/model.dart';
import 'package:tut_application/domain/repository/repository.dart';
import 'package:tut_application/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure,Authentication>> execute(
      RegisterUseCaseInput input) async
  {
    return await _repository.register(RegisterRequest(input.countryMobileCode,
        input.userName, input.email, input.password, input.profilePicture,input.mobileNumber));
  }
}
class RegisterUseCaseInput
{
  String countryMobileCode;
  String mobileNumber;
  String userName;
  String email;
  String password;
  String profilePicture;
  RegisterUseCaseInput(this.countryMobileCode,this.mobileNumber,this.userName, this.email,
  this.password, this.profilePicture);
}