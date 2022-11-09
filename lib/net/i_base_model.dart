
///解析数据基类
abstract class BaseModel<T> {
  static const int normal = 0;
  static const int loading = 1;
  static const int success = 2;
  static const int error = 3;
  static const int disconnect = 4;

  int _state = normal;

  set state(int value) {
    _state = value;
  }

  T parseData(Map<String, dynamic> json);
}



