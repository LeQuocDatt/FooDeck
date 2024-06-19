import 'package:template/data/provider/user_provider.dart';

abstract class IUserRepository {
  Future<Map<String, dynamic>> getUser();
}

class UserRepository implements IUserRepository {
  final UserProvider userProvider;

  UserRepository({required this.userProvider});
  @override
  Future<Map<String, dynamic>> getUser() {
    return userProvider.getUser();
  }
}
