import 'package:rxdart/rxdart.dart';

import 'repository.dart';
import 'user_model.dart';

class Bloc {
  final _repository = Repository();

  Bloc() {
    getMoreUsers();
  }

  final _listOfUsersSubject = BehaviorSubject<List<User>>();

  Stream<List<User>> get outListOfUsers => _listOfUsersSubject.stream;
  Sink<List<User>> get inputListOfUsers => _listOfUsersSubject.sink;

  List<User> listOfUsers = [];

  int currentPage = 0;

  getMoreUsers() async {
    currentPage++;
    var moreData = await _repository.getUsers(currentPage);
    for (var user in moreData) {
      listOfUsers.add(user);
    }
    inputListOfUsers.add(listOfUsers);
  }

  dispose() {
    _listOfUsersSubject.close();
  }
}
