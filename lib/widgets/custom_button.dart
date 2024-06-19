import 'package:template/source/export.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.icons,
    required this.content,
    required this.color,
    this.borderSide,
    this.heightBox,
    this.widthBox,
    this.paddingLeft,
    this.contentColor,
    this.contentWeight,
    this.borderRadius,
    this.paddingBottom,
  });

  final VoidCallback? onPressed;
  final Widget? icons;
  final String content;
  final Color? contentColor;
  final FontWeight? contentWeight;
  final Color color;
  final BorderSide? borderSide;
  final double? heightBox, widthBox, paddingLeft, borderRadius, paddingBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom ?? 16),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label: CustomText(
            content: content,
            color: contentColor ?? Colors.white,
            fontWeight: contentWeight ?? FontWeight.w700),
        icon: icons ?? const SizedBox(),
        style: ButtonStyle(
            padding: WidgetStatePropertyAll(
                EdgeInsets.only(right: paddingLeft ?? 0)),
            elevation: const WidgetStatePropertyAll(10),
            fixedSize: WidgetStatePropertyAll(
                Size(widthBox ?? double.maxFinite, heightBox ?? 62)),
            backgroundColor: WidgetStatePropertyAll(color),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 30),
                side: borderSide ?? BorderSide.none))),
      ),
    );
  }
}
