import 'package:flutter/material.dart';
import 'package:news/core/bases/base_view_state/base_view_state.dart';

class BaseViewModel<T> extends ChangeNotifier {
  BaseViewState<T> viewState;

  BaseViewModel({required this.viewState});

  void refreshWithState(BaseViewState<T> newState) {
    this.viewState = newState;
    notifyListeners();
  }
}
