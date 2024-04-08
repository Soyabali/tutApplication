import 'dart:async';
import 'package:tut_application/presentation/base/baseviewmodel.dart';
import 'package:tut_application/domain/usecase/login_usecase.dart';
import 'package:tut_application/presentation/common/freezed_data_classes.dart';
import 'package:tut_application/presentation/common/state_render/state_render.dart';
import 'package:tut_application/presentation/common/state_render/state_render_impl.dart';

class LoginViewModel extends BaseViewModel
with LoginViewModelInputs,LoginViewModelOutputs {
  // StreamController
  StreamController _userNameStreamController = StreamController<String>.broadcast();
  StreamController _passwordStreamController = StreamController<String>.broadcast();
  StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController = StreamController<bool>();
  var loginObject = LoginObject("", "");
  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  //input
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }
  @override
  void start()
  {
    // view tells states renders, please show the content of the screen
    inputState.add(ContentState());
  }
  // ---input
  @override
  Sink get inputPassword => _passwordStreamController.sink;
  @override
  Sink get inputUserName => _userNameStreamController.sink;
  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;
  @override
  login() async
  {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
     (await _loginUseCase.execute(
        LoginUseCaseInput(loginObject.username,
                          loginObject.password)))
        .fold(
            (failure) => {
            // left -> failure
            inputState.add(ErrorState(StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message))
            },
            (data) {
          // right -> success (data)
          inputState.add(ContentState());
          // Navigate to main screen after the login
            isUserLoggedInSuccessfullyStreamController.add(true);
            });
  }
  @override
  setPassword(String password)
  {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operations same as kotline
    _validate();
  }
  @override
  setUserName(String userName)
  {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(username: userName); // data class operation same as kotlin
    _validate();
  }
  // output
  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map((password) =>
          _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userNameStreamController.stream.map((userName) =>
          _isUserNameValid(userName));
  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // private function
  _validate() {
    inputIsAllInputValid.add(null);
  }
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.username);
  }
}
abstract class LoginViewModelInputs
{
  // three function for Action
  setUserName(String userName);
  setPassword(String password);
  login();
  // two sinks for Stream
Sink get inputUserName;
Sink get inputPassword;
Sink get inputIsAllInputValid;
}
abstract class LoginViewModelOutputs
{
 // two Stream
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
