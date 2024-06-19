import 'package:template/source/export.dart';

class BottomIcons {
  final String label;
  final IconData icon;

  BottomIcons({required this.label, required this.icon});
}

List<BottomIcons> bottomIcons = [
  BottomIcons(label: 'Explore', icon: Icons.search),
  BottomIcons(label: 'Saved', icon: Icons.favorite_border),
  BottomIcons(label: 'Notifications', icon: Icons.notifications_none),
  BottomIcons(label: 'Profile', icon: Icons.person_2_outlined),
];
