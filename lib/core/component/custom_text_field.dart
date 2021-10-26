import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {

  CustomTextField({
      this.type,
    this.controller,
      this.focusNode,
      this.keyboardType,
      this.textAlign,
      this.style,
      this.decoration,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.isDense= false,
      this.textCapitalization = TextCapitalization.none,
      this.readOnly = false,
      this.showCursor,
      this.autoFocus,
      this.selectAllOnFocus,
      this.showClearIcon = false,
      this.roundBorders = false,
      this.value,
      this.onTap,
      this.onChanged,
      this.onSubmitted,
      this.onBlur,
      this.onFinished,
      this.inputFormatter,
      Key? key}

      ) : super(key: key);

  final CustomTextFieldType? type;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final TextStyle? style;
  final InputDecoration? decoration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool isDense;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final bool? showCursor;
  final bool? autoFocus;
  final bool? selectAllOnFocus;
  final bool showClearIcon;
  final bool roundBorders;
  final String? value;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function(String)? onBlur;

  final void Function(String)? onFinished;
  final List<TextInputFormatter>? inputFormatter;




  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  bool _submitHandled = false;
  bool _controlerIsInternal = false;
  var _clearIconVisible = false;
  var _prevText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.controller == null){
      _controller = TextEditingController();
      _controlerIsInternal = true;
    }else {
      _controller = widget.controller!;
    }

    _controller.addListener(() {
      if(_controller.text.isEmpty && _prevText.isNotEmpty){
        setState(() {
          _clearIconVisible = false;
        });
      }else if (_controller.text.isNotEmpty && _prevText.isEmpty){
       setState(() {
         _clearIconVisible = true;
       });
      }
    });

    if(widget.value != null) _controller.text = widget.value!;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {_handleFocusChange;});
  }
  void selectAll(){
    final text =_controller.text;
    if(text.isEmpty)return;
    _controller.selection=TextSelection(baseOffset: 0,extentOffset: text.length);
  }

  void _handleFocusChange(){
    if(_focusNode.hasFocus){
      if(widget.selectAllOnFocus ?? false) selectAll();
    }else {
      final text = _controller.text;
      if (widget.onBlur != null) {
        widget.onBlur! (text);
      }else if (!_submitHandled && widget.onFinished!=null){
        widget.onFinished!(text);
      }
      _submitHandled=false;
    }
  }
  void _handleSubmitted(String text) {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(text);
    } else if (widget.onFinished != null) {
      widget.onFinished!(text);
      _submitHandled = true;
    }
  }

  void _handleClearField() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _controller.clear();
      if (widget.onChanged != null) widget.onChanged!('');
    });
  }

  InputDecoration _buildDecoration(
      ThemeData theme, CustomTextFieldType? fieldType) {
    final suffixIcon = (widget.showClearIcon && _controller.text != '')
        ? IconButton(
      onPressed: _handleClearField,
      icon: Icon(Icons.clear),
    )
        : widget.suffixIcon;
    final borderRadius = widget.roundBorders ? 20.0 : 4.0;

    switch (fieldType) {
      case CustomTextFieldType.outline:
        return InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(4),
          ),
          hintText: widget.hintText,
          isDense: widget.isDense,
          contentPadding:
          const EdgeInsets.only(left: 15, bottom: 12, top: 15, right: 15),
        );
      case CustomTextFieldType.borlderless:
        return InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          isDense: true,
          contentPadding: widget.isDense
              ? EdgeInsets.fromLTRB(0, 8, 0, 0)
              : EdgeInsets.fromLTRB(10, 14, 10, 6),
        );
      case CustomTextFieldType.standard:
      default:
        return InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: suffixIcon,
        );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container();
  }

}

enum CustomTextFieldType { standard, outline, borlderless }