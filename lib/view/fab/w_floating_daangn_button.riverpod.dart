import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test04dm/view/fab/w_floating_daangn_button.state.dart';



final floatingButtonStateProvider =
    StateNotifierProvider<FloatingButtonStateNotifier, FloatingButtonState>(
  (ref) => FloatingButtonStateNotifier(
    const FloatingButtonState(false),
  ),
);

class FloatingButtonStateNotifier extends StateNotifier<FloatingButtonState> {
  FloatingButtonStateNotifier(super.state);

  bool needToMakeButtonBigger = false;

  void onTapButton() {
    final isExpanded = state.isExpanded;

    state = state.copyWith(isExpanded: !state.isExpanded);

    if(needToMakeButtonBigger){
      needToMakeButtonBigger = false;
    }

    if(!isExpanded) {
      needToMakeButtonBigger = true;
    }
  }
}

