import 'package:chaty/src/extensions/extensions.dart';
import 'package:chaty/src/services/api.dart';

class BaseProvider extends ChangeNotifier {
  Api api = Api();
  BaseProvider(String? token) {
    api.token = token;
    if (token != null) this.token = token;
  }
  String token = '';
  String _message = '';
  String get message => _message;
  setMessage(msg) {
    _message = msg;
    notifyListeners();
  }

  String _error = '';
  String get error => _error;
  setError(msg) {
    _error = msg;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
