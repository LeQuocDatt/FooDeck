import 'package:template/source/export.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.autofocus,
      this.readOnly,
      this.obscureText,
      this.onTap,
      this.textCapitalization,
      this.controller,
      this.textColor,
      this.prefix,
      this.suffix,
      this.onChanged,
      this.inputFormatters,
      this.keyboardType,
      this.borderRadius,
      this.textInputAction,
      this.textAlign,
      this.labelText,
      this.backGroundColor,
      this.errorText,
      this.height,
      this.activeValidate,
      this.borderColor,
      this.labelColor,
      this.maxLines,
      this.floatingLabelColor});
  final int? maxLines;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Widget? prefix, suffix;
  final double? borderRadius, height;
  final String? labelText, errorText;
  final bool? activeValidate, autofocus, readOnly, obscureText;
  final Color? borderColor,
      floatingLabelColor,
      labelColor,
      textColor,
      backGroundColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              alignment: Alignment.center,
              height: height ?? 74,
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              decoration: BoxDecoration(
                  color: backGroundColor ?? Colors.white,
                  boxShadow: activeValidate == false
                      ? [
                          const BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ]
                      : null,
                  border: activeValidate == true
                      ? Border.all(color: borderColor ?? Colors.red)
                      : null,
                  borderRadius: BorderRadius.circular(borderRadius ?? 16)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: prefix ?? const SizedBox.shrink(),
                  ),
                  Expanded(
                      child: TextFormField(
                          onTap: onTap,
                          textInputAction:
                              textInputAction ?? TextInputAction.next,
                          textAlign: textAlign ?? TextAlign.start,
                          autofocus: autofocus ?? false,
                          textCapitalization:
                              textCapitalization ?? TextCapitalization.none,
                          readOnly: readOnly ?? false,
                          controller: controller,
                          style: AppTextStyle.inter
                              .copyWith(fontSize: 17, color: textColor),
                          onChanged: onChanged,
                          inputFormatters: inputFormatters,
                          keyboardType: keyboardType,
                          obscureText: obscureText ?? false,
                          decoration: InputDecoration(
                              labelText: labelText,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelStyle: AppTextStyle.inter
                                  .copyWith(fontSize: 17, color: labelColor),
                              floatingLabelStyle: AppTextStyle.inter.copyWith(
                                  color: activeValidate == true
                                      ? floatingLabelColor ?? Colors.red
                                      : Colors.black),
                              border: InputBorder.none))),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: suffix ?? const SizedBox.shrink(),
                  )
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: CustomText(
            content: errorText ?? '',
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
