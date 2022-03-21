import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  int drawePageIndex = 0;

  bool isCollapsed = true;
  bool isDecorated = false;

  void setPageIndex(int index){
    drawePageIndex = index;
            notifyListeners();
  }

int getPageIndex(){
  return drawePageIndex;
}

  void setCollapesed() {
        notifyListeners();

    isCollapsed = !isCollapsed;
  }


  void setDecorated() {
        notifyListeners();
    isDecorated = !isDecorated;
  }

  bool getDecorated() {
    return isDecorated;
  }

  void setanimationController(AnimationController controller) {
    _controller = controller;
  }

  AnimationController getAnimationController() {
    return _controller;
  }

  void setScaleAnimation(Animation scaleanimation) {
    _scaleAnimation = scaleanimation;
  }

  Animation getScaleAnimation() {
    return _scaleAnimation;
  }

  void setMenuScaleAnimation(Animation menuanimation) {
    _menuScaleAnimation = menuanimation;
  }

  Animation getMenuScaleAnimation() {
    return _menuScaleAnimation;
  }

  void setSlideAnimation(Animation slideanimation) {
    _slideAnimation = slideanimation;
  }

  Animation getSlideAnimation() {
    return _slideAnimation;
  }
}
