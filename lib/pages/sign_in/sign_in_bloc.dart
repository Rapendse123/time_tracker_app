import 'dart:async';

class SignInBloc{
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose(){
    _isLoadingController.close();
  }

  // adding isLoading to the 'sink' of _isLoadingController
  void setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);
}