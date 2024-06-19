import 'package:template/source/export.dart';

class ProfileIcons {
  final String label;
  final IconData icon;

  ProfileIcons({required this.label, required this.icon});
}

List<ProfileIcons> profileIcons = [
  ProfileIcons(label: 'Edit Account', icon: Icons.person_outline),
  ProfileIcons(label: 'My Locations', icon: Icons.location_on_outlined),
  ProfileIcons(label: 'My Orders', icon: Icons.shopping_bag_outlined),
  ProfileIcons(label: 'Payment Methods', icon: Icons.payment_outlined),
  ProfileIcons(label: 'My Reviews', icon: Icons.star_border),
  ProfileIcons(label: 'About Us', icon: Icons.info_outline),
  ProfileIcons(label: 'Data Usage', icon: Icons.data_thresholding_outlined),
  ProfileIcons(label: 'Light Mode', icon: Icons.dark_mode_outlined),
  ProfileIcons(label: 'Log Out', icon: Icons.logout),
];
