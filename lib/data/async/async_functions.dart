import 'package:template/source/export.dart';

final supabase = Supabase.instance.client;

enum PopUp { allow, deny }

class AsyncFunctions {
  static updateData(String table, Map<String, dynamic> info, PopUp show,
      [BuildContext? context, String? message]) async {
    try {
      late dynamic id;
      var response = await supabase.from(table).select('id');
      var records = response.toList() as List;
      for (var record in records) {
        var userId = record['id'];
        id = userId;
      }
      await supabase.from(table).update(info).eq('id', id).then((value) =>
          show == PopUp.allow
              ? customSnackBar(context!, Toast.success, message!)
              : null);
    } catch (e) {
      if (context!.mounted) {
        show == PopUp.allow
            ? customSnackBar(context, Toast.error, e.toString())
            : Future.error(e.toString());
      }
    }
  }

  static insertData(String table, Map<String, dynamic> info, PopUp show,
      [BuildContext? context, String? message]) async {
    try {
      await supabase.from(table).insert(info).then((value) =>
          show == PopUp.allow
              ? customSnackBar(context!, Toast.success, message!)
              : null);
    } catch (e) {
      if (context!.mounted) {
        show == PopUp.allow
            ? customSnackBar(context, Toast.error, e.toString())
            : Future.error(e.toString());
      }
    }
  }

  static deleteData(String table, Map<String, Object> info, PopUp show,
      [BuildContext? context, String? message]) async {
    try {
      late dynamic id;
      var response = await supabase.from(table).select('id');
      var records = response.toList() as List;
      for (var record in records) {
        var userId = record['id'];
        id = userId;
      }
      await supabase.from(table).delete().match(info).eq('id', id).then(
          (value) => show == PopUp.allow
              ? customSnackBar(context!, Toast.success, message!)
              : null);
    } catch (e) {
      if (context!.mounted) {
        show == PopUp.allow
            ? customSnackBar(context, Toast.error, e.toString())
            : Future.error(e.toString());
      }
    }
  }

  static updateUser([String? email, String? password]) async {
    try {
      await supabase.auth.updateUser(UserAttributes(
        email: email,
        password: password,
      ));
    } catch (e) {
      Future.error(e.toString());
    }
  }

  static logOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      Future.error(e.toString());
    }
  }
}
