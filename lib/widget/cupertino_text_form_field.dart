import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CupertinoTextFormField extends FormField<String> {
  /// Creates a [FormField] that contains a [TextField].
  ///
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initalValue] or the empty string.
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  CupertinoTextFormField({
    Key key,
    this.controller,
    String initialValue,
    FocusNode focusNode,
    BoxDecoration decoration = const BoxDecoration(),
    String placeholder,
    TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction,
    TextStyle placeholderStyle,
    TextStyle style,
    StrutStyle strutStyle,
    TextDirection textDirection,
    TextAlign textAlign = TextAlign.start,
    bool autofocus = false,
    bool obscureText = false,
    bool autocorrect = true,
    bool autovalidate = false,
    bool maxLengthEnforced = true,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    VoidCallback onEditingComplete,
    ValueChanged<String> onFieldSubmitted,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
    bool enabled = true,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder buildCounter,
  }) : assert(initialValue == null || controller == null),
        assert(textAlign != null),
        assert(autofocus != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(autovalidate != null),
        assert(maxLengthEnforced != null),
        assert(scrollPadding != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
        (maxLines == null) || (minLines == null) || (maxLines >= minLines),
        'minLines can\'t be greater than maxLines',
        ),
        assert(expands != null),
        assert(
        !expands || (maxLines == null && minLines == null),
        'minLines and maxLines must be null when expands is true.',
        ),
        assert(maxLength == null || maxLength > 0),
        assert(enableInteractiveSelection != null),
        super(
        key: key,
        initialValue: controller != null ? controller.text : (initialValue ?? ''),
        onSaved: onSaved,
        validator: validator,
        autovalidate: autovalidate,
        enabled: enabled,
        builder: (FormFieldState<String> field) {
          final _CupertinoTextFormFieldState state = field;
//          final BoxDecoration effectiveDecoration = (decoration ?? const BoxDecoration())
//              .applyDefaults(Theme.of(field.context).inputDecorationTheme);
//          placeholder = placeholder == null ? field.errorText : placeholder;
          return CupertinoTextField(
            controller: state._effectiveController,
            focusNode: focusNode,
            decoration: decoration,
//            decoration: effectiveDecoration.copyWith(errorText: field.errorText),
            placeholder: placeholder,
            placeholderStyle: placeholderStyle,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            style: style,
            strutStyle: strutStyle,
            textAlign: textAlign,
//            textDirection: textDirection,
            textCapitalization: textCapitalization,
            autofocus: autofocus,
            obscureText: obscureText,
            autocorrect: autocorrect,
            maxLengthEnforced: maxLengthEnforced,
            maxLines: maxLines,
            minLines: minLines,
            expands: expands,
            maxLength: maxLength,
            onChanged: field.didChange,
            onEditingComplete: onEditingComplete,
            onSubmitted: onFieldSubmitted,
            inputFormatters: inputFormatters,
            enabled: enabled,
            cursorWidth: cursorWidth,
            cursorRadius: cursorRadius,
            cursorColor: cursorColor,
            scrollPadding: scrollPadding,
            keyboardAppearance: keyboardAppearance,
//            enableInteractiveSelection: enableInteractiveSelection,
//            buildCounter: buildCounter,
          );
        },
      );

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController controller;

  @override
  _CupertinoTextFormFieldState createState() => _CupertinoTextFormFieldState();
}

class _CupertinoTextFormFieldState extends FormFieldState<String> {
  TextEditingController _controller;

  TextEditingController get _effectiveController => widget.controller ?? _controller;

  @override
  CupertinoTextFormField get widget => super.widget;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(CupertinoTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller = TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(widget.controller.text);
        if (oldWidget.controller == null)
          _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }
}