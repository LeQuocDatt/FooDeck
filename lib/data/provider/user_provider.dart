import 'package:template/source/export.dart';

class UserProvider {
  Future<Map<String, dynamic>> getUser() async {
    try {
      final data = await supabase.from('users').select();
      if (data.isNotEmpty) {
        return data[0];
      }
      return {};
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
