import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_application/data/data_source/local_data_source.dart';
import 'package:tut_application/data/data_source/remote_data_source.dart';
import 'package:tut_application/data/network/app_api.dart';
import 'package:tut_application/data/network/dio_factory.dart';
import 'package:tut_application/data/network/network_info.dart';
import 'package:tut_application/data/repository/repository_Impl.dart';
import 'package:tut_application/domain/repository/repository.dart';
import 'package:tut_application/domain/usecase/forgot_password_usecase.dart';
import 'package:tut_application/domain/usecase/home_usecase.dart';
import 'package:tut_application/domain/usecase/login_usecase.dart';
import 'package:tut_application/domain/usecase/register_usecase.dart';
import 'package:tut_application/domain/usecase/store_details_usecase.dart';
import 'package:tut_application/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:tut_application/presentation/login/login_viewmodel.dart';
import 'package:tut_application/presentation/main/home/home_viewmodel.dart';
import 'package:tut_application/presentation/register/register_viewmodel.dart';
import 'package:tut_application/presentation/store_details/store_details_viewmodel.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  // network info
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(DataConnectionChecker())
  );
  // dio factory
  instance.registerLazySingleton<DioFactory>(
          () => DioFactory(instance()));
  // app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImplementer(instance()));
  // local data source
  instance.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImplementer());

  // repository
  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance(), instance(),instance()));
}
  // DI APPLY LOGINMODULE
  initLoginModule() {
    if (!GetIt.I.isRegistered<LoginUseCase>()) {
      instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
      instance.registerFactory<LoginViewModel>(() =>
          LoginViewModel(instance()));
    }
  }
  // FogotPassword
initFogotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() =>
        ForgotPasswordViewModel(instance()));
  }
}
initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
            () => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
            () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(
            () => ImagePicker());
  }
}
initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
            () => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(
            () => HomeViewModel(instance()));
  }
}
initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
            () => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
            () => StoreDetailsViewModel(instance()));
  }
}
