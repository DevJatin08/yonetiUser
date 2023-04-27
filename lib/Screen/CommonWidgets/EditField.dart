import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/Constant/ConstantValues.dart';

class EditField extends StatefulWidget {
  final String? hint;
  FormFieldValidator? validator;
  FormFieldValidator? onsave;
  ValueChanged<String>? onChanged;
  List<TextInputFormatter>? inputFormatters;
  InputDecoration inputDecoration;
  TextInputType? keyboardType = TextInputType.text;
  TextEditingController? controller;
  bool? suffix;

  EditField(
      {required this.controller,
      this.hint,
      this.onChanged,
      this.inputFormatters,
      this.validator,
      this.onsave,
      required this.inputDecoration,
      this.keyboardType,
      this.suffix = false});

  @override
  _EditFieldState createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onSaved: widget.onsave,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
        style: TextStyle(color: editFeildText, fontFamily: 'bold'),
        cursorColor: Colors.grey,
        obscureText: widget.suffix! ? showPassword : false,
        decoration: widget.inputDecoration.copyWith(
            hintText: widget.hint,
            suffixIconConstraints: BoxConstraints(
              minHeight: 0,
              minWidth: 0,
            ),
            suffixIcon: widget.suffix!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      !showPassword ? Icons.visibility : Icons.visibility_off,
                      color: primaryColor,
                    ))
                : Container(
                    width: 0,
                    height: 0,
                    color: Colors.red,
                  ),
            hintStyle: TextStyle(fontFamily: 'semiBold', color: Color(0xff9d9d9d))));
  }
}

class AuthEditField extends StatefulWidget {
  final String? hint;
  InputDecoration inputDecoration;
  TextInputType? keyboardType = TextInputType.text;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  bool? suffix;
  bool? isPhoneNumber;

  AuthEditField(
      {required this.controller,
      this.hint,
      required this.inputDecoration,
      this.validator,
      this.keyboardType,
      this.isPhoneNumber = false,
      this.suffix = false});

  @override
  _AuthEditField createState() => _AuthEditField();
}

class _AuthEditField extends State<AuthEditField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
        controller: widget.controller,
        maxLength: widget.isPhoneNumber! ? 10 : 100,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        style: TextStyle(color: editFeildText, fontFamily: 'bold'),
        cursorColor: Colors.grey,
        obscureText: widget.suffix! ? showPassword : false,
        decoration: widget.inputDecoration.copyWith(
            counterText: '',
            // isCollapsed: true,
            labelText: widget.hint,
            suffixIconConstraints: BoxConstraints(
              minHeight: 0,
              minWidth: 0,
            ),
            suffixIcon: widget.suffix!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      !showPassword ? Icons.visibility : Icons.visibility_off,
                      color: primaryColor,
                    ))
                : Container(
                    width: 0,
                    height: 0,
                    color: Colors.red,
                  ),
            labelStyle: TextStyle(fontFamily: 'semiBold', color: Color(0xff9d9d9d))));
  }
}

class EditableTextField extends StatefulWidget {
  final String? hint;
  String label;
  bool suffix;
  final Widget? widget;
  int? maxLine = 1;
  final TextInputType? keyboardType;
  int? wordLimit = 50;
  FormFieldValidator? validator;
  InputDecoration inputDecoration;
  TextEditingController? controller;
  TextInputAction? action;
  final bool readOnly;
  final VoidCallback? onTap;
  EditableTextField({
    required this.controller,
    this.hint,
    this.validator,
    required this.inputDecoration,
    required this.suffix,
    required this.label,
    this.keyboardType,
    this.maxLine,
    this.readOnly = false,
    this.wordLimit,
    this.widget,
    this.action,
    this.onTap,
  });

  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool focus = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      focusUpdate();
    });
  }

  focusUpdate() {
    setState(() {
      focus = !focus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: Color(0xfff1f7f7), border: Border.all(color: focus ? primaryColor : Colors.transparent), borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label.toString(),
              style: TextStyle(color: Color(0xff888e8e), fontSize: 12, fontFamily: 'bold'),
            ),
            TextFormField(
                maxLines: widget.maxLine,
                maxLength: widget.wordLimit,
                validator: widget.validator,
                focusNode: focusNode,
                keyboardType: widget.keyboardType,
                style: TextStyle(color: Color(0xff434849), fontSize: 12),
                controller: widget.controller,
                cursorColor: Colors.grey,
                textInputAction: widget.action,
                readOnly: widget.readOnly,
                onTap: widget.onTap,
                decoration: widget.inputDecoration.copyWith(
                    counterText: '',
                    hintText: widget.hint,
                    hintStyle: TextStyle(color: Color(0xff9da2a3), fontSize: 12),
                    suffixIconConstraints: BoxConstraints(maxHeight: 30, minHeight: 0),
                    suffixIcon: widget.suffix
                        ? widget.widget
                        : Container(
                            width: 0,
                            height: 0,
                          ))),
          ],
        ),
      ),
    );
  }
}
