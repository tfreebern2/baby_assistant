import 'child.dart';
import 'package:scoped_model/scoped_model.dart';

class AppState extends Model {
  List<Child> _children;

  List<Child> get allChildren => List<Child>.from(_children);

  Child getChild(int id) => _children.singleWhere((v) => v.id == id);

  List<Child> searchChildren(String name) => _children
      .where((v) => v.firstName.toLowerCase().contains(name.toLowerCase()))
      .toList();

}