import 'package:template/source/export.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.content,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textDecoration,
      this.textAlign,
      this.textOverflow,
      this.maxLines});

  final String content;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(content,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: textOverflow ?? TextOverflow.ellipsis,
        style: AppTextStyle.inter.copyWith(
            fontSize: fontSize ?? 17,
            fontWeight: fontWeight,
            color: color,
            decoration: textDecoration));
  }
}
