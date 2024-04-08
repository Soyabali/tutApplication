import 'package:dartz/dartz.dart';
import 'package:tut_application/data/network/failure.dart';
import 'package:tut_application/domain/model/model.dart';
import 'package:tut_application/domain/repository/repository.dart';
import 'package:tut_application/domain/usecase/base_usecase.dart';

class HomeUseCase extends BaseUseCase<void,HomeObject>
{
  Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
      }
}