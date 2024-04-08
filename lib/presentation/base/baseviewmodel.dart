import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tut_application/presentation/common/state_render/state_render_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs
{
  StreamController _inputStateStreamController = BehaviorSubject<FlowState>();
  // input
  @override
  Sink get inputState => _inputStateStreamController.sink;
  // output
  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);
  @override
  void dispose() {
    _inputStateStreamController.close();
  }
  //shared variable and function that will be used
  // through any view model.
}
abstract class BaseViewModelInputs
{
  void start();// will be called while init.. of ViewModel
  void dispose();// will be called when ViewModle die

 Sink get inputState;
}
abstract class BaseViewModelOutputs
{
 Stream<FlowState> get outputState;
}