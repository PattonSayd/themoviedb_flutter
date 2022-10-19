import 'package:flutter/cupertino.dart';

class StateNotifierProvider<Model extends ChangeNotifier>
    extends StatefulWidget {
  final Widget child;
  final bool isDisposeModel;
  final Model Function() create;
  const StateNotifierProvider({
    super.key,
    required this.create,
    this.isDisposeModel = true,
    required this.child,
  });

  @override
  State<StateNotifierProvider> createState() =>
      _StateNotifierProviderState<Model>();

  static T? watch<T extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_NotifierProvider<T>>()
        ?.notifier;
  }

  static T? read<T extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<_NotifierProvider<T>>()
        ?.widget;

    return widget is _NotifierProvider<T> ? widget.notifier : null;
  }
}

class _StateNotifierProviderState<Model extends ChangeNotifier>
    extends State<StateNotifierProvider<Model>> {
  late final Model _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isDisposeModel) _model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _NotifierProvider(model: _model, child: widget.child);
  }
}

class _NotifierProvider<Model extends ChangeNotifier>
    extends InheritedNotifier<Model> {
  const _NotifierProvider({
    Key? key,
    required Model model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);
}

class Provider<Model> extends InheritedWidget {
  final Model model;
  const Provider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static Model? watch<Model>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<Model>>()?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<Provider<Model>>()
        ?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(covariant Provider oldWidget) {
    return model != oldWidget.model;
  }
}
